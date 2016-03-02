require './lib/json_object'

module Swagger2Cat
  module Node
    class Fields < Base
      include Shape::Sequence

      def initialize(operation, models)
        super("")
        @models = models
        @parameters = operation["parameters"]
        add_fields
      end

      private
      def add_fields
        path_params.each do |param|
          add Field.new(param["name"], param)
        end

        body_params.each do |param|
          type = param['type']
          model= Swagger2CAT::JsonObject.new(models[type] || {})

          ordered_fields(model).each do |key, field|
            add Field.new(key, field)
          end
        end

      end

      def body_params
        parameters.select{|p| p["paramType"] == "body"}
      end

      def path_params
        parameters.select{|p| p["paramType"] == "path"}
      end

      attr_reader :parameters, :models

      def ordered_fields(model)
        required = model.required([])

        required_fields = not_required_fields = {}
        model.properties({}).each do |key, _|
          if required.include?(key)
            model.properties[key]["required"] = true
            required_fields[key] = model.properties[key]
          else
            not_required_fields[key] = model.properties[key]
          end
        end
        required_fields.merge(not_required_fields)
      end

      def body_other_fields
        required = model.required([])
        model.properties({}).select{|key, _| !required.include?(key)}.each{|k, v| v["required"] = false}
      end
    end
  end
end

