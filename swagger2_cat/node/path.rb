module Swagger2Cat
  module Node
    class Path < Base
      include Shape::Final

      def initialize(spec)
        if spec['swaggerVersion'] == '1.2'
          path = spec["resourcePath"]
        elsif spec['swagger'] == '2.0'
          path = spec["basePath"]
        end
        super(path.gsub(/{([^}\/]*)}/, ':\1'))
      end
    end
  end
end

