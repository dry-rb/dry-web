Dummy.container do |container, config|
  container.register(:logger) do
    Logger.new(config.root.join('log/app.log'))
  end
end
