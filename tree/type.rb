require_relative 'block'

module Tree
  class Type < Tree::Base
    include Tree::Block

    def initialize(resource, json, model)
      @json= json
      @resource = resource

      super(resource[0..-2])

      href(json.last['path'])
      fields(model)
      output(model)
      actions
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
