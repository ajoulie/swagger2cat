require_relative 'meth/comment'
require_relative 'block'

module Tree
  class Service < Tree::Base
    include Tree::Meth::Comment
    include Tree::Block

    def host(value)
      add Tree::Host.new(value)
    end

    def path(value)
      add Tree::Path.new(value)
    end

    def no_cert_check(value)
      add Tree::NoCertCheck.new(value)
    end

    def name
      "service"
    end
  end
end
