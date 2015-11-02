require 'persistence/user_repo'

Dummy::Container.namespace('persistence') do |container|
  container.register('rom') do
    if ROM.container
      ROM.container
    else
      ROM.use(:auto_registration)

      ROM.setup(:sql, 'postgres://localhost/rodakase')

      %w(relations commands).each do |type|
        Dir[container.root.join("lib/persistence/#{type}/**/*.rb")].each(&method(:require))
      end

      ROM.finalize.container
    end
  end

  container.register('commands.create_user') do
    container['persistence.rom'].command(:users)[:create]
  end

  container.register('user_repo') do
    Persistence::UserRepo.new(container['persistence.rom'])
  end
end
