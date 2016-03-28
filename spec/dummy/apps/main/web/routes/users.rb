class Main::Application < Rodakase::Application
  route('users') do |r|
    r.get(to: 'main.views.users.index')

    r.resolve('main.requests.users.create') do |t|
      r.post do
        t.(r[:user]) do |m|
          m.success do
            response.status = 201
          end

          m.failure do |err|
            r.redirect '/users'
          end
        end
      end
    end
  end
end
