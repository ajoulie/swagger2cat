module Tree
  class Root < Base

    def initialize(json)
      @json = json
      comment "CAT namespace file generated with swagger2CAT"
      comment "from swagger specification #{json["swaggerVersion"]}"
    end

    def service(value)
      add Tree::Service.new(value, @json)
    end

    def type(value, types_json, model)
      type = Tree::Type.new(value, types_json, model)
      add type
    end

    def to_s
      @children.map(&:to_s).join("\n")
    end
  end
end

