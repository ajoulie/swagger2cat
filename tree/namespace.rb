module Tree
  class Namespace < Base
    include Tree::Block

    def initialize(value, specs)
      @specs = specs
      @value = value
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

