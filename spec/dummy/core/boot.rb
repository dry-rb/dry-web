require 'logger'
require 'rodakase/renderer'

require_relative 'dummy/application'
require_relative 'dummy/view'

Dummy::Container.configure do |container|
  container.register(:logger) do
    Logger.new(container.root.join('log/app.log'))
  end

  container.register(:renderer) do
    Rodakase::Renderer.new(container.root.join('templates'))
  end
end

Dummy::Container.finalize!
