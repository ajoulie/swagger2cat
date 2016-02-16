module Tree
  class Base
    def initialize(value)
      @value = value
    end

    def add(child)
      @children ||= []
      @children << child
    end
    alias_method :<<, :add

    attr_reader :value

    def cat_key
      # Mainly underscore name
      name.gsub(/::/, '/').
          gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
          gsub(/([a-z\d])([A-Z])/,'\1_\2').
          tr("-", "_").
          downcase
    end
  end
end


