require_relative 'block'

module Tree
  class Action < Tree::Base
    include Tree::Final

    def initialize(operation)
      @operation = operation
      value = case @operation["method"]
      when "POST"
        "create"
      when "DELETE"
        "delete"
      when "PUT"
        "update"
      when "PATCH"
        "patch"
      when "GET"
        if @operation["type"].match(/List$/)
          "list"
        else
          "show"
        end
      else
        raise "Unknown verb #{@operation["method"]}"
      end

      super(value)
      #verb(@operation["method"])
    end

    def verb(verb)
      add Verb.new(verb)
    end

    class Verb < Tree::Base
      include Tree::Final
    end
  end
end
