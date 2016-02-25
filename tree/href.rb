module Tree
  class Href < Tree::Base
    include Tree::Shape::Final

    def initialize(href)
      super(href.gsub(/{([^}\/]*)}/, ':\1'))
    end
  end
end

