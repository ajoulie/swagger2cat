module Tree
  module Shape
    module FinalMultiple
      def to_s(tab = 0)
        "#{' '*tab*2}#{cat_key} #{@value.compact.map{|v| "\"#{v}\""}.join(", ")}"
      end
    end
  end
end
