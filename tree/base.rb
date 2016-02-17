require_relative 'meth/comment'
module Tree
  class Base
    include Tree::Meth::Comment

    def initialize(value)
      @value = value
      @children = []
    end

    def add(child)
      @children ||= []
      @children << child
    end
    alias_method :<<, :add

    attr_reader :value

    protected
    def cat_key
      # Mainly demodularize and underscore class name
      self.class.name.split("::").last.
          gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
          gsub(/([a-z\d])([A-Z])/,'\1_\2').
          tr("-", "_").
          downcase
    end
  end
end


