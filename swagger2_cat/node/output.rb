require './lib/json_object'

module Swagger2Cat
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

