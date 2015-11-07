require 'logger'

require 'rodakase/view'
require 'rodakase/transaction'

require_relative 'dummy/application'
require_relative 'dummy/view'

Dummy::Container.configure do |container|
  container.register(:logger, Logger.new(container.root.join('log/app.log')))

  container.register(:renderer, Rodakase::View::Renderer.new(container.root.join('templates')))
end

Dummy::Container.finalize!
