module Swagger2Cat
  def self.attr_final(name)
    attr_final_class(name)
  end

  def self.attr_final_class(name)
    klass = Class.new(Node::Base) do
      include Shape::Final
    end
    Swagger2Cat.const_set(name, klass)
  end

  def self.attr_final_meth(name)
    Swagger2Cat.define_singleton_method(name.downcase) do |value|
      Swagger2Cat.const_get(name).new(value)
    end
  end
  module Shape
    module Final
      def to_s(tab = 0)
        case value
        when TrueClass, FalseClass, Integer
          "#{' '*tab*2}#{cat_key} #{@value}"
        else
          "#{' '*tab*2}#{cat_key} \"#{@value}\""
        end
      end
    end
  end
end
