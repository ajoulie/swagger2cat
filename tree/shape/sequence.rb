module Tree
  module Shape
    module Sequence
      def to_s(tab = 0)
        cat = []
        cat << @children.map{|c| c.to_s(tab)}
        cat
      end
    end
  end
end
