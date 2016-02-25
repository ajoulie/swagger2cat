module Tree
  module Node
    class Href < Base
      include Shape::Final

      def initialize(href)
        super(href.gsub(/{([^}\/]*)}/, ':\1'))
      end
    end
  end
end

