require 'rodakase/application'
require_relative 'import'

module Dummy
  class Application < Rodakase::Application
    setting :container, Container.instance

    $LOAD_PATH.unshift(root.join('lib').to_s)

    route do |r|
      r.multi_route
    end

    load_routes!
  end
end
