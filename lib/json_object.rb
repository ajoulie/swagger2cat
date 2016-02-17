module Swagger2CAT
  class JsonObject
    def initialize(json)
      @json = json
    end

    def method_missing(method, *arg)
      @json.fetch(method.to_s) {arg.first}
    end
  end
end
