module Swagger2Cat
  module Node
    class Host < Base
      include Shape::Final

      def initialize(spec)
        if spec['swaggerVersion'] == '1.2'
          host = spec["basePath"]
        elsif spec['swagger'] == '2.0'
          host = spec["host"]
        end
        super(host)
      end
    end
  end
end

