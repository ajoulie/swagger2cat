
module Tree
  class Type < Tree::Base
    include Tree::Shape::Block

    def initialize(resource, json, model, prefix=nil)
      @json= json
      @resource = resource

      name = [prefix, resource[0..-2]].compact.join("_")
      super(name)

      fields(model) if model
      output(model) if model
      actions
    end

    def to_s(*args)
      cat = [""]
      cat << super
      cat.flatten

    end

    def href(value)
      add Tree::Href.new(value)
    end

    def output(json_model)
      add Tree::Output.new(json_model)
    end

    def fields(json_model)
      add Tree::Fields.new(json_model)
    end

    def actions
      add Tree::Actions.new(@json, @resource)
    end
  end
end
