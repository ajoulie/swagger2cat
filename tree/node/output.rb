require './lib/json_object'

module Tree
  module Node
    class Output < Base
      include Shape::FinalMultiple

      def initialize(json)
        @json= Swagger2CAT::JsonObject.new(json)
        super(@json.properties.keys)
      end
    end
  end
end

