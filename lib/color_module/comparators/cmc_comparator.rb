module ColorModule
  module Comparators
    class CMCComparator
      def initialize(l=2, c=1)
        @l =  l 
        @c = c 
      end  
      def self.compare(first_color, second_color, params={})
        l =  params[:l] || 2 
        c =  params[:c] || 1
        color1 =  first_color.convert_to(:lab)
        color2 =  second_color.convert_to(:lab)
        factor_conversion =  180/Math::PI   #obtener en grados
        dL =  color1.L - color2.L
        da =  color1.a - color2.a
        db =  color1.b - color2.b
        _C1 = Math.sqrt(color1.a**2 + color1.b**2)
        _C2 = Math.sqrt(color2.a**2 + color2.b**2)
        dC =  _C1 - _C2
        dH = Math.sqrt(da**2 + db**2 - dC**2 )
        sL = (color1.L < 16) ? ( 0.511) : (0.040975*color1.L / (1.0 + 0.01765*color1.L))
        sC = (0.0638*_C1 / (1+0.0131*_C1)) + 0.638
        _H = Math.atan2(color1.b, color1.a) * factor_conversion  #obtener en grados
        _H1 = (_H >= 0) ? (_H) : (_H + 360)
        _T = ((164..345).include?(_H)) ? ( 0.56 + (0.2*Math.cos((_H1 + 168)/factor_conversion)).abs ) : ( 0.36 + (0.4*Math.cos((_H1 + 35)/factor_conversion)).abs )
        _F = Math.sqrt( _C1**4 / (_C1**4 + 1900) )
        sH = sC*( _F*_T + 1 - _F)

        dE = Math.sqrt( (dL/(l*sL))**2 + (dC/(c*sC))**2 + (dH/sH)**2 )
        Result.new(dE, dL, da, db)
      end


      def compare(first_color, second_color)
        self.class.compare(first_color, second_color, l: @l, c: @c)
      end

      def compare_multiple(*colors)
        _results = Array.new
        raise NotImplementedError
      end

      private
      class Result
        def initialize(dE, dL, da, db)
          @dE =  dE
          @dL =  dL
          @da =  da
          @db =  db
        end
        def resume
          puts "", "Results of comparation:"
          puts " %cEcmc:  %f " %[916, @dE]
          puts " %<delta>cL   :  %<dl>f\n %<delta>ca   :  %<da>f\n %<delta>cb   : %<db>f" %{delta: 916, dl: @dL, da: @da, db: @db}
          puts ""
        end  
      end  
    end
  end
end
