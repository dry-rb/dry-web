require 'logger'
require 'rodakase/transaction'

require_relative 'dummy/container'

Dummy::Container.configure do |container|
  container.register(:logger, Logger.new(container.root.join('log/app.log')))
  container.register(:transaction, Rodakase::Transaction::Composer.new(container))
end

require 'dummy/application'
require 'dummy/view'
require 'dummy/requests'

Dir[Dummy::Container.root.join('web/requests/**/*.rb')].each(&method(:require))
