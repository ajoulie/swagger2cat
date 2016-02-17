require './lib/json_object'

module Tree
  class Output < Tree::Base
    include Tree::FinalMultiple

    def initialize(json)
      @json= Swagger2CAT::JsonObject.new(json)
      super(@json.properties.keys)
    end
  end
end

