require_relative 'meth/comment'
module Tree
  class Root < Base
    include Tree::Meth::Comment

    def initialize
    end

    def service(value)
      serv = Tree::Service.new(value)
      add serv
      yield(serv)
    end

    def to_s
      @children.map(&:to_s).join("\n")
    end
  end
end

