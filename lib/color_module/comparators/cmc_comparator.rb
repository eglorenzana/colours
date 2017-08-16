module ColorModule
  module Comparators
    # CIE delta E cmc comparator; for get the difference factor for two colors
    class CMCComparator
      @@comparator_name = :cmc

      def initialize(l = 2, c = 1)
        @l = l
        @c = c
      end

      def self.compare(first_color, second_color, params = {})
        l = params[:l] || 2
        c = params[:c] || 1
        color1 = first_color.convert_to(:lab)
        color2 = second_color.convert_to(:lab)
        delta_e, data = cmc_calculate(color1, color2, l, c)
        Result.new(first_color, second_color, delta_e, params.merge(data))
      end

      def self.cmc_calculate(color1, color2, l, c)
        dl, da, db = delta_for(color1, color2)
        c1, _c2, delta_c = magnitude_and_delta(color1, color2)
        delta_h = Math.sqrt(da**2 + db**2 - delta_c**2)
        s_l = color1.L < 16 ? 0.511 : (0.040975 * color1.L / (1.0 + 0.01765 * color1.L))
        s_c, factor_f = factor_on_c1(c1)
        factor_t = factor_on_color1(color1)
        s_h = s_c * (factor_f * factor_t + 1 - factor_f)
        delta_e = Math.sqrt((dl / (l * s_l))**2 + (delta_c / (c * s_c))**2 + (delta_h / s_h)**2).round(DECIMAL_DIGITS)
        [delta_e, { dl: dl, da: da, db: db }]
      end

      def self.delta_for(color1, color2)
        dl = color1.L - color2.L
        da = color1.a - color2.a
        db = color1.b - color2.b
        [dl, da, db]
      end

      def self.magnitude_and_delta(color1, color2)
        c1 = Math.sqrt(color1.a**2 + color1.b**2)
        c2 = Math.sqrt(color2.a**2 + color2.b**2)
        delta_c = c1 - c2
        [c1, c2, delta_c]
      end

      def self.factor_on_c1(c1)
        s_c = (0.0638 * c1 / (1 + 0.0131 * c1)) + 0.638
        factor_f = Math.sqrt(c1**4 / (c1**4 + 1900))
        [s_c, factor_f]
      end

      def self.factor_on_color1(color1)
        factor_conversion = 180 / Math::PI # obtener en grados
        factor_h = Math.atan2(color1.b, color1.a) * factor_conversion # obtener en grados
        factor_h1 = factor_h >= 0 ? factor_h : (factor_h + 360)
        if (164..345).cover?(factor_h)
          0.56 + (0.2 * Math.cos((factor_h1 + 168) / factor_conversion)).abs
        else
          0.36 + (0.4 * Math.cos((factor_h1 + 35) / factor_conversion)).abs
        end
      end

      def compare(first_color, second_color)
        self.class.compare(first_color, second_color, l: @l, c: @c)
      end

      #  Result for CIE delta Ecmc comparator
      class Result
        attr_reader :value, :color1, :color2
        alias de value
        def initialize(first_color, second_color, delta_e, params)
          @color1 = first_color
          @color2 = second_color
          @value = delta_e
          @dl = params[:dl].round(2 * DECIMAL_DIGITS)
          @da = params[:da].round(2 * DECIMAL_DIGITS)
          @db = params[:db].round(2 * DECIMAL_DIGITS)
          @l = params[:l]
          @c = params[:c]
        end

        def resume
          puts '', 'Results of comparation:'
          puts format(' %cEcmc (%d:%d):  %f ', 916, @l, @c, @delta_e)
          puts format(" %<delta>cL   :  %<dl>f", delta: 916, dl: @dl)
          puts format(" %<delta>ca   :  %<da>f", delta: 916, da: @da)
          puts format(" %<delta>cb   :  %<db>f", delta: 916, db: @db)
        end
      end
    end
  end
end
