require 'rodakase/application'
require_relative 'import'

module Dummy
  class Application < Rodakase::Application
    setting :container, Container

    route do |r|
      r.multi_route
    end

    load_routes!
  end
end
