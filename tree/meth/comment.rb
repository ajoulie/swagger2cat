module Tree
  module Meth
    module Comment
      def comment(value)
        add Tree::Comment.new(value)
      end
    end
  end
end
