require './lib/json_object'

module Tree
  class Actions < Tree::Base
    include Tree::Sequence

    def initialize(operations)
      super("")
      @operations= operations

      add_actions
    end

    def add_actions
      @operations.each do |operation|
        add Tree::Action.new(operation)
      end
    end
  end
end


