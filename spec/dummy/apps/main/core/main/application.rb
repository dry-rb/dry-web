require 'rodakase/application'
require_relative 'container'

module Main
  class Application < Rodakase::Application
    setting :container, Main::Container

    route do |r|
      r.multi_route
    end

    load_routes!
  end
end
