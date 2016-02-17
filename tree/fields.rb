require './lib/json_object'

module Tree
  class Fields < Tree::Base
    include Tree::Sequence

    def initialize(json)
      super("")
      @json= Swagger2CAT::JsonObject.new(json)
      add_fields
    end

    def add_fields
      required_fields.merge(other_fields).each do |key, field|
        add Tree::Field.new(key, field)
      end
    end

    def required_fields
      required = @json.required([])
      @json.properties.select{|key, _| required.include?(key)}.each{|k, v| v["required"] = true}
    end

    def other_fields
      required = @json.required([])
      @json.properties.select{|key, _| !required.include?(key)}.each{|k, v| v["required"] = false}
    end
  end
end

