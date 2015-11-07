require 'logger'

require 'rodakase/view'
require 'rodakase/transaction'

require_relative 'dummy/application'
require_relative 'dummy/view'

Dummy::Container.configure do |container|
  container.register(:logger, Logger.new(container.root.join('log/app.log')))

  container.register(:transaction, Rodakase::Transaction::Composer.new(container))

  container.register(:renderer, Rodakase::View::Renderer.new(container.root.join('templates')))
end

Dummy::Container.finalize!

require 'dummy/requests'

Dir[Dummy::Container.root.join('web/requests/**/*.rb')].each(&method(:require))
