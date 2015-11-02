Dummy.container do |container, config|
  container.register(:logger) do
    Logger.new(config.root.join('log/app.log'))
  end

  container.register(:renderer) do
    Rodakase::Renderer.new(config.root.join('templates'))
  end
end
