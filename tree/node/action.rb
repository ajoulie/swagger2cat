module Tree
  module Node
    class Action < Base
      include Shape::Block
      include Meth::Comment

      def initialize(operation, path, name= nil)
        @operation = operation
        name ||= action_name

        super(name)

        comment(operation["summary"]) unless operation["summary"].empty?
        verb(operation["method"])
        path(path)
        type(operation["type"])
      end

      def cat_key
        'action'
      end

      private
      attr_reader :operation

      def verb(verb)
        add Verb.new(verb)
      end

      def path(path)
        add Path.new(path)
      end

      def type(name)
        add Type.new(name)
      end

      def action_name
        case operation["method"]
        when "POST"
          "create"
        when "DELETE"
          "delete"
        when "PUT"
          "update"
        when "PATCH"
          "patch"
        when "GET"
          if operation["type"].match(/List$/)
            "list"
          else
            "show"
          end
        when 'OPTIONS'
          'options'
        when 'HEAD'
          'head'
        else
          nil
        end
      end

      class Type < Base
        include Shape::Final
        def initialize(value)
          super(value.gsub('.', '_'))
        end
      end

      class Verb < Base
        include Shape::Final
      end
    end
  end
end
