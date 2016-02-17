module Tree
  class Path < Tree::Base
    include Tree::Final

    def initialize(path)
      super(path.gsub(/{([^}\/]*)}/, ':\1'))
    end
  end
end

