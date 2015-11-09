require 'inflecto'

require_relative 'main/container'

require 'main/application'
require 'main/view'
require 'main/requests'

Main::Container.configure do |container|
  container.auto_load!(container.root.join('lib/persistence/repositories')) do |repo_class|
    -> { Inflecto.constantize(repo_class).new(container['persistence.rom']) }
  end
end

Dir[Main::Container.root.join('requests/**/*.rb')].each(&method(:require))
