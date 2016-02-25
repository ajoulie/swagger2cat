module Tree
  module Node
    class ActionCustom < Base
      include Shape::Block

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
        add Path.new(path)
      end

      def type(name)
        add Type.new(name)
      end

      class Type < Base
        include Shape::Final
      end

      class Verb < Base
        include Shape::Final
      end
    end
  end
end
