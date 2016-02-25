module Swagger2Cat
  module Node
    class Actions < Base
      include Shape::Sequence

      ACTION_REGEXP = /^[a-zA-Z0-9]+$/

        def initialize(apis, resource_name)
          super("")
          @resource_name= resource_name
          @apis = apis

          add_actions
        end

      def add_action_custom_and_cruds
        @apis.each do |api|
          if api["path"].match(/\/#{@resource_name}\/{name}\/([^\/]*)$/)
            add ActionCustom.new(api, $1)
          else
            add ActionCRUD.new(api["operations"])
          end
        end
      end

      def add_actions
        @apis.each do |api|
          # TODO be more generic
          if api["path"].match(/\/#{@resource_name}\/{name}\/([^\/]*)$/)
            action = $1
            if action.match(ACTION_REGEXP)
              add Action.new(api["operations"].first, api["path"], action)
            end
          else
            api["operations"].each do |operation|
              add Action.new(operation, api["path"])
            end
          end
        end
      end
    end
  end
end

