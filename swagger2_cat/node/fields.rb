require './lib/json_object'

module Swagger2Cat
  module Node
    class Fields < Base
      include Shape::Sequence

      def initialize(operation, model)
        super("")
        @model= Swagger2CAT::JsonObject.new(model || {})
        @parameters = operation["parameters"]
        add_fields
      end

      def add_fields
        path_params.each do |param|
          add Field.new(param["name"], param)
        end

        body_required_fields.merge(body_other_fields).each do |key, field|
          add Field.new(key, field)
        end
      end

      def path_params
        parameters.select{|p| p["paramType"] == "path"}
      end

      attr_reader :parameters, :model

      def body_required_fields
        required = model.required([])
        model.properties({}).select{|key, _| required.include?(key)}.each{|k, v| v["required"] = true}
      end

      def body_other_fields
        required = model.required([])
        model.properties({}).select{|key, _| !required.include?(key)}.each{|k, v| v["required"] = false}
      end
    end
  end
end

