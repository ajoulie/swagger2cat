module Tree
  class Comment < Base
    def to_s(tab = 0)
      "#{' '*tab*2}# #{@value}"
    end
  end
end
