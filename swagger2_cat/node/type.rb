module Swagger2Cat
  module Node
    class Type < Base
      include Shape::Block

      def initialize(resource, json, media_types, create_operation, prefix=nil)
        @json= json
        @resource = resource
        @media_types = media_types
        @create_operation = create_operation

        name = [prefix, resource[0..-2]].compact.join("_")
        super(name)

        fields
        output
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

      def output
        return unless model_for_outputs

        add Output.new(model_for_outputs)
      end

      def fields
        return unless create_operation

        add Fields.new(create_operation, media_types)
      end

      def actions
        add Actions.new(@json, @resource)
      end

      private
      # json media types of the swagger spec
      attr_reader :media_types

      # operation used to create the resource
      attr_reader :create_operation

      def model_for_outputs
        unless create_operation.nil?
          create_body_param = create_operation["parameters"].find{|p| p["paramType"] == "body"}
        end
        create_body_param ? media_types[create_body_param["type"]] : nil
      end
    end
  end
end
