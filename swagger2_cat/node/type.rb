module Swagger2Cat
  module Node
    class Type < Base
      include Shape::Block

      def initialize(resource, json, model, create_operation, prefix=nil)
        @json= json
        @resource = resource

        name = [prefix, resource[0..-2]].compact.join("_")
        super(name)

        fields(create_operation, model)
        output(model)
        actions
      end

      def to_s(*args)
        cat = [""]
        cat << super
        cat.flatten

      end

      def href(value)
        add Href.new(value)
      end

      def output(model)
        return unless model

        add Output.new(model)
      end

      def fields(create_operation, model)
        return unless create_operation

        add Fields.new(create_operation, model)
      end

      def actions
        add Actions.new(@json, @resource)
      end
    end
  end
end
