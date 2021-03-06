module Swagger2Cat
  module Shape
    module Block
      def to_s(tab = 0)
        cat = []

        block_comments.each do |comment|
          cat << comment.to_s(tab)
        end

        value = @value ? " \"#{@value}\"" : ""
        cat << "#{' '*tab*2}#{cat_key}#{value} do"
        cat << @children.map{|c| c.to_s(tab + 1)}
        cat << "#{' '*tab*2}end"
        cat
      end

      def comment_block(comment)
        block_comments << Node::Comment.new(comment)
      end

      def block_comments
        @comments ||= {}
        @comments[:before_block] ||= []
      end
    end

    def self.attr_block(name)
      attr_block_class(name)
      attr_block_meth(name)
    end

    def self.attr_block_class(name)
      klass = Class.new(Base) do

        def to_s(tab = 0)
          cat = []
          cat << "#{name.downcase} #{@value} do"
          cat << children.map{|c| c.to_s(tab + 1)}
          cat << "end"
          cat
        end
      end

      Swagger2Cat.const_set(name, klass)
    end

    def self.attr_block_meth(name)
      Swagger2Cat.define_singleton_method(name.downcase) do |value|
        Swagger2Cat.const_get(name).new(value)
      end
    end
  end
end
