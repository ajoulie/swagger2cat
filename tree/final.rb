module Tree
  def self.attr_final(name)
    attr_final_class(name)
  end

  def self.attr_final_class(name)
    klass = Class.new(Base) do
      def to_s(tab = 0)
        "#{' '*tab*2}#{cat_key} \"#{@value}\""
      end
    end
    klass.instance_eval {define_method(:name) {name}}
    Tree.const_set(name, klass)
  end

  def self.attr_final_meth(name)
    Tree.define_singleton_method(name.downcase) do |value|
      Tree.const_get(name).new(value)
    end
  end

end
