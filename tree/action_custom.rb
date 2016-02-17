require_relative 'block'

module Tree
  class ActionCustom < Tree::Base
    include Tree::Block

    def initialize(api, operation_name)
      operation = api["operations"].first
      super(operation_name)

      verb(operation["method"])
      path(api['path'])
      type(operation["type"])
    end

    def cat_key
      'action'
    end

    def verb(verb)
      add Verb.new(verb)
    end

    def path(path)
      add Tree::Path.new(path)
    end

    def type(name)
      add Type.new(name)
    end

    class Type < Tree::Base
      include Tree::Final
    end

    class Verb < Tree::Base
      include Tree::Final
    end
  end
end
