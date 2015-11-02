module Dummy
  class Application < Rodakase::Application
    route('users') do |r|
      r.get(to: 'ui.users.hello')

      r.resolve('persistence.user_repo') do |user_repo|
        r.post do
          user_repo.create(r.params['user'])

          response.status = 201
        end
      end
    end
  end
end
