module Tree
  class ActionCRUD < Tree::Base
    include Tree::Shape::FinalMultiple

    def initialize(operations)

      @operations = operations

      super(action_names)
    end

    def action_names
      @operations.map do |operation|
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
        else
          nil
        end
      end
    end

    def cat_key
      'action'
    end
  end
end
