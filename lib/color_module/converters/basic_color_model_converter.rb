module ColorModule
  module Converters
    module BasicColorModelConverter
      EPSILON = 216.0/24389.0
      KAPPA =  24389.0/27.0
      E = 0.08
      REF_WHITE = [0.96720, 1.00000, 0.81427] #reference  D50 , 10  ; from http://www.easyrgb.com/en/math.php	
      require 'matrix'
      def rgb_to_cmyk(model)
        cmyk = Array.new
        cmyk_model = Spaces::CMYKModel.new
        if model.component_values.select{|v| v == 0}.length == model.components.length
          cmyk =  [Spaces::CMYKModel::MIN] * 3 + [Spaces::CMYKModel::KMAX]
        else
          _components = model.components  #verificar que el acceso siempre es en orden r g b
          _components.each_with_index{|c, index| cmyk[index] = 1 - c.value.fdiv(model.class::MAX)}
          k =  cmyk.min
          cmyk.map!{|v| (v-k)/(1-k)*cmyk_model.class::MAX }
          cmyk << k*cmyk_model.class::KMAX
        end
        cmyk_model.assign_components(cmyk)
        cmyk_model
      end
      def cmyk_to_rgb(model)
        rgb_model =  Spaces::RGBModel.new
        r = rgb_model.class::RMAX*(1- (model.C*(1-model.K) + model.K )/model.class::CMAX)
        g = rgb_model.class::GMAX*(1- (model.M*(1-model.K) + model.K )/model.class::MMAX)
        b = rgb_model.class::BMAX*(1- (model.Y*(1-model.K) + model.K )/model.class::YMAX)
        rgb_model.assign_components(r,g,b)		
        rgb_model		
      end

      def rgb_to_xyz(model)
        _R = model.R.fdiv(model.class::RMAX)
        _G = model.G.fdiv(model.class::GMAX)
        _B = model.B.fdiv(model.class::BMAX)
        _RGB_values = [_R, _G, _B]
        rgb_values = _RGB_values.map{|v| (v <= E) ?  (100.0*v/KAPPA) :  ((v+0.16)/(1.16))**3} #v mayuscula
        m_CIE_E = [	[0.4887180, 0.3106803, 0.2006017],
          [0.1762044, 0.8129847, 0.0108109],
          [0.0, 0.0102048, 0.9897952]
        ]
        rgb_vector = Matrix.column_vector(rgb_values)
        matrix = Matrix.rows(m_CIE_E)
        xyz_vector = matrix* rgb_vector
        xyz_model = Spaces::XYZModel.new
        xyz_model.assign_components(xyz_vector.to_a.flatten)		
        xyz_model
      end
      def xyz_to_rgb(model)
        xyz_values = [model.X, model.Y, model.Z]
        xyz_vector = Matrix.column_vector(xyz_values)
        mInv_CIE_E = [	[2.3706743, -0.9000405, -0.4706338],
          [-0.5138850, 1.4253036, 0.0885814],
          [0.0052982, -0.0146949, 1.0093968]
        ]
        rgb_vector = Matrix.rows(mInv_CIE_E) * xyz_vector
        _RGB_values = rgb_vector.to_a.flatten.map{|v| (v <= EPSILON) ? ( v*KAPPA/100.0) : (1.16*v**(1.0/3.0) - 0.16)}
        rgb_model = Spaces::RGBModel.new
        _R = _RGB_values[0]*rgb_model.class::RMAX
        _G = _RGB_values[1]*rgb_model.class::GMAX
        _B = _RGB_values[2]*rgb_model.class::BMAX
        rgb_model.assign_components(_R, _G, _B)
        rgb_model
      end

      def xyz_to_lab(model)
        e = EPSILON
        k =  KAPPA
        ref_white = REF_WHITE
        xr =  model.X/ ref_white[0]
        yr =  model.Y/ ref_white[1]
        zr =  model.Z/ ref_white[2]

        fx = ((xr > e) ? (xr**(1.0/3.0)) : ((k*xr+16.0)/(116.0)))
        fy = ((yr > e) ? (yr**(1.0/3.0)) : ((k*yr+16.0)/(116.0)))
        fz = ((zr > e) ? (zr**(1.0/3.0)) : ((k*zr+16.0)/(116.0)))

        lab_model = Spaces::LABModel.new
        _L =  116.0*fy - 16
        a =  500.0*(fx - fy)
        b =  200.0*(fy - fz)

        lab_model.assign_components(_L, a, b)
        lab_model
      end
      def lab_to_xyz(model)
        e = EPSILON
        fy = (model.L + 16.0)/116.0
        fx = model.a / 500 + fy
        fz = fy - model.b / 200
        _x = (fx**3 > e) ? (fx**3.0) : ( (116.0*fx-16.0)/KAPPA)
        _z = (fz**3 > e) ? (fz**3.0) : ( (116.0*fz-16.0)/KAPPA)
        _y = (model.L > KAPPA*e) ? ((fy)**3.0) : ( model.L/KAPPA)
        ref_white = REF_WHITE
        x =  _x * ref_white[0]
        y =  _y * ref_white[1]
        z =  _z * ref_white[2]
        xyz_model =  Spaces::XYZModel.new
        xyz_model.assign_components(x, y, z)
        xyz_model
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