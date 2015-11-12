require_relative 'main/container'

Main::Container.finalize! do |container|
  container.auto_register!('lib/persistence/repositories') do |repo_class|
    -> { repo_class.new(container['persistence.rom']) }
  end
end

require 'main/application'
require 'main/view'
require 'main/requests'

Main::Container.require('requests/**/*.rb')
