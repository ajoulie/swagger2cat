module Tree
  class Actions < Tree::Base
    include Tree::Sequence

    def initialize(apis, resource_name)
      super("")
      @resource_name= resource_name
      @apis = apis

      add_actions
    end

    def add_actions
      @apis.each do |api|
        if api["path"].match(/\/#{@resource_name}\/{name}\/([^\/]*)$/)
          add Tree::ActionCustom.new(api, $1)
        else
          add Tree::ActionCRUD.new(api["operations"])
        end
      end
    end
  end
end


