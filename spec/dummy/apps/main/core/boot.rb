require 'inflecto'

require_relative 'main/container'

Main::Container.configure do |container|
  container.auto_register!('lib/persistence/repositories') do |repo_class|
    -> { Inflecto.constantize(repo_class).new(container['persistence.rom']) }
  end
end

require 'main/application'
require 'main/view'
require 'main/requests'

Dir[Main::Container.root.join('requests/**/*.rb')].each(&method(:require))
