module Tree
  class Href < Tree::Base
    include Tree::Final

    def initialize(href)
      super(href.gsub(/{([^}\/]*)}/, ':\1'))
    end
  end
end

