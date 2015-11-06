module Dummy
  class Application < Rodakase::Application
    route('users') do |r|
      r.resolve('ui.view_scope') do |view_scope|
        r.get(to: 'ui.users.index', call_with: [view_scope])

        r.resolve('persistence.commands.create_user') do |create_user|
          r.post do
            create_user.(r.params['user'])

            response.status = 201
          end
        end
      end
    end
  end
end
