module Tree
  class Namespace < Base
    include Tree::Block

    def initialize(value, specs)
      @specs = specs
      comment "CAT namespace file generated with swagger2CAT"
      comment "from swagger specification #{specs["swaggerVersion"]}"
      comment "My first namespace is #{value}"
    end

    def service
      add Tree::Service.new(@specs)
    end

    def type(value, types_json, model, prefix = nil)
      type = Tree::Type.new(value, types_json, model, prefix)
      add type
    end
  end
end

