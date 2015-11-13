require_relative 'main/container'

Main::Container.finalize!

require 'main/application'
require 'main/view'
require 'main/requests'

Main::Container.require('requests/**/*.rb')
