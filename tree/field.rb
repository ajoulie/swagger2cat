require_relative 'block'

module Tree
  class Field < Tree::Base
    include Tree::Block

    def initialize(value, json)
      super(value)
      type(json.fetch("type") {json.fetch("$ref")})
      required(true) if json["required"]
    end

    private
    def type(value)
      add Type.new(value)
    end

    def required(value)
      add Tree::Required.new(value)
    end

    class Type < Tree::Base
      def to_s(tab = 0)
        "#{' '*tab*2}type \"#{@value}\""
      end
    end
  end

end
