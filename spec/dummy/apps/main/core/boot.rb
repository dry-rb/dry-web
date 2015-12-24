require_relative 'main/container'

Main::Container.finalize! do |container|
  require 'logger'
  container.register(:logger, Logger.new(container.root.join('log/app.log')))

  require 'rodakase/transaction'
  container.register(:transaction, Rodakase::Transaction::Composer.new(container))
end

require 'main/application'
require 'main/view'
require 'main/requests'

Main::Container.require('requests/**/*.rb')
