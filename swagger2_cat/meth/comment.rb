module Swagger2Cat
  module Meth
    module Comment
      def comment(value)
        add Node::Comment.new(value)
      end
    end
  end
end
