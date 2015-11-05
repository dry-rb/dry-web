Dummy::Container.namespace('persistence') do |container|
  container.register('commands.create_user') do
    container['persistence.rom'].command(:users)[:create]
  end
end
