module ColorModule
  module Converters
    # Implements the methods for convert specific spaces
    module BasicColorModelConverter
      EPSILON = 216.0 / 24_389.0
      KAPPA = 24_389.0 / 27.0
      E = 0.08
      REF_WHITE = [0.96720, 1.00000, 0.81427] # reference  D50 , 10  ; from http://www.easyrgb.com/en/math.php
      require 'matrix'

      def rgb_to_cmyk(model)
        cmyk = []
        cmyk_model = Spaces::CMYKModel
        if model.component_values.select(&:zero?).length == model.components.length
          cmyk = [cmyk_model::MIN] * 3 + [cmyk_model::KMAX]
        else
          # verificar que el acceso siempre es en orden r g b
          model.components.each_with_index { |c, index| cmyk[index] = 1 - c.value.fdiv(model.class::MAX) }
          k = cmyk.min
          cmyk.map! { |v| (v - k) / (1 - k) * cmyk_model::MAX }
          cmyk << k * cmyk_model::KMAX
        end
        pack_result(cmyk_model, cmyk)
      end

      def cmyk_to_rgb(model)
        rgb_model = Spaces::RGBModel
        r = rgb_model::RMAX * (1 - (model.C * (1 - model.K) + model.K) / model.class::CMAX)
        g = rgb_model::GMAX * (1 - (model.M * (1 - model.K) + model.K) / model.class::MMAX)
        b = rgb_model::BMAX * (1 - (model.Y * (1 - model.K) + model.K) / model.class::YMAX)
        pack_result(rgb_model, [r, g, b])
      end

      def rgb_to_xyz(model)
        r = model.R.fdiv(model.class::RMAX)
        g = model.G.fdiv(model.class::GMAX)
        b = model.B.fdiv(model.class::BMAX)
        rgb_values = [r, g, b]
        rgb_values.map! { |v| v <= E ? (100.0 * v / KAPPA) : ((v + 0.16) / 1.16)**3 } # upcase v, refers to V in formula

        # define the conversion matrix
        matrix_cie_e = [
          [0.4887180, 0.3106803, 0.2006017],
          [0.1762044, 0.8129847, 0.0108109],
          [0.0, 0.0102048, 0.9897952]
        ]
        rgb_vector = Matrix.column_vector(rgb_values)
        matrix = Matrix.rows(matrix_cie_e)
        xyz_vector = (matrix * rgb_vector).to_a.flatten
        pack_result(Spaces::XYZModel, xyz_vector)
      end

      def xyz_to_rgb(model)
        xyz_values = [model.X, model.Y, model.Z]
        xyz_vector = Matrix.column_vector(xyz_values)
        # define the conversion matrix
        inverse_matrix_cie_e = [
          [2.3706743, -0.9000405, -0.4706338],
          [-0.5138850, 1.4253036, 0.0885814],
          [0.0052982, -0.0146949, 1.0093968]
        ]
        rgb_vector = Matrix.rows(inverse_matrix_cie_e) * xyz_vector
        rgb_values = rgb_vector.to_a.flatten.map { |v| v <= EPSILON ? (v * KAPPA / 100.0) : (1.16 * v**(1.0 / 3.0) - 0.16) }
        rgb_model = Spaces::RGBModel
        r = rgb_values[0] * rgb_model::RMAX
        g = rgb_values[1] * rgb_model::GMAX
        b = rgb_values[2] * rgb_model::BMAX
        pack_result(rgb_model, [r, g, b])
      end

      def xyz_to_lab(model)
        e = EPSILON
        k = KAPPA
        ref_white = REF_WHITE
        xr =  model.X / ref_white[0]
        yr =  model.Y / ref_white[1]
        zr =  model.Z / ref_white[2]

        fx = xr > e ? xr**(1.0 / 3.0) : (k * xr + 16.0) / 116.0
        fy = yr > e ? yr**(1.0 / 3.0) : (k * yr + 16.0) / 116.0
        fz = zr > e ? zr**(1.0 / 3.0) : (k * zr + 16.0) / 116.0

        l =  116.0 * fy - 16
        a =  500.0 * (fx - fy)
        b =  200.0 * (fy - fz)
        pack_result(Spaces::LABModel, [l, a, b])
      end

      def lab_to_xyz(model)
        e = EPSILON
        fy = (model.L + 16.0) / 116.0
        fx = model.a / 500 + fy
        fz = fy - model.b / 200
        x = fx**3 > e ? fx**3.0 : (116.0 * fx - 16.0) / KAPPA
        z = fz**3 > e ? fz**3.0 : (116.0 * fz - 16.0) / KAPPA
        y = model.L > KAPPA * e ? fy**3.0 : model.L / KAPPA
        ref_white = REF_WHITE
        x *= ref_white[0]
        y *= ref_white[1]
        z *= ref_white[2]
        pack_result(Spaces::XYZModel, [x, y, z])
      end

      def pack_result(model, components)
        result_model = model.new
        result_model.assign_components(*components)
        result_model
      end

      def to_rgb
        raise NotImplementedError
      end

      def to_xyz
        raise NotImplementedError
      end

      def to_cmyk
        raise NotImplementedError
      end

      def to_lab
        raise NotImplementedError
      end
    end
  end
end
