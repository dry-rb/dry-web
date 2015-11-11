require_relative 'main/container'

Main::Container.configure do |container|
  container.auto_register!('lib/persistence/repositories') do |repo_class|
    -> { container.const(repo_class).new(container['persistence.rom']) }
  end
end

require 'main/application'
require 'main/view'
require 'main/requests'

Main::Container.require('requests/**/*.rb')
