module Dummy
  class Application < Rodakase::Application
    route('users') do |r|
      r.get(to: 'ui.users.hello')

      r.resolve('persistence.commands.create_user') do |create_user|
        r.post do
          create_user.(r.params['user'])

          response.status = 201
        end
      end
    end
  end
end
