module Swagger2Cat
  module Node
    class Namespace < Base
      include Shape::Block

      def initialize(value, specs)
        @specs = specs
        @value = value
      end

      def service
        add Service.new(@specs)
      end

      def type(value, types_json, model, prefix = nil)
        type = Type.new(value, types_json, model, prefix)
        add type
      end
    end
  end
end

