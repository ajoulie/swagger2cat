module Swagger2Cat
  module Node
    class Path < Base
      include Shape::Final

      def initialize(path)
        super(path.gsub(/{([^}\/]*)}/, ':\1'))
      end
    end
  end
end

