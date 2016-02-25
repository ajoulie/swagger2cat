module Tree
  module Node
    class Base
      include Meth::Comment

      def initialize(value)
        @value = value
        @children = []
      end

      def add(child)
        @children ||= []
        @children << child
      end
      alias_method :<<, :add

      attr_reader :value, :children

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
end


