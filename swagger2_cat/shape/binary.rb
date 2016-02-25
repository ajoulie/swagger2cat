module Swagger2Cat
  module Shape
    module Binary
      def to_s(tab = 0)
        "#{' '*tab*2}#{cat_key} #{@value}"
      end
    end
  end
end

