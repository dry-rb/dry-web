module Dummy
  class Application < Rodakase::Application
    route('users') do |r|
      r.resolve('ui.view_scope') do |view_scope|
        r.get(to: 'ui.users.index', call_with: [scope: view_scope])

        r.resolve('requests.users.create') do |t|
          r.post do
            t.(r[:user]) do |m|
              m.success do
                response.status = 201
              end

              m.failure do |err|
                err.on(:validation) do |v|
                  r.redirect '/users'
                end
              end
            end
          end
        end
      end
    end
  end
end
