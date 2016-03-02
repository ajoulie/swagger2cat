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
        custom_actions.each do |action, api|
          add Action.new(api["operations"].first, api["path"], action)
        end

        crud_actions.each do |action|
          action["operations"].each do |operation|
            add Action.new(operation, action["path"])
          end
        end
      end

      private
      # CRUD actions on resource
      def crud_actions
        @apis.select do |api|
          # TODO make {name} more generic
          api["path"].match(/\/#{@resource_name}\/{name}[\/]{0,1}$/) || api["path"].match(/\/#{@resource_name}$/)
        end
      end

      # All actions but CRUD ones
      def custom_actions
        @custom_action = {}

        @apis.each do |api|
          # TODO make {name} more generic
          if api["path"].match(/\/#{@resource_name}\/{name}\/([^\/]*)$/)
            action = $1
            if action.match(ACTION_REGEXP)
              @custom_action[action] = api
            end
          end
        end
        @custom_action
      end
    end
  end
end


