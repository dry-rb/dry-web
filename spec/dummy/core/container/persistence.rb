require 'persistence/user_repo'

Dummy::Container.namespace('persistence') do |container|
  container.register('commands.create_user') do
    container['persistence.rom'].command(:users)[:create]
  end

  container.register('user_repo') do
    Persistence::UserRepo.new(container['persistence.rom'])
  end
end
