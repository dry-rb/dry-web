require 'dry/web/application'

module Simple
  class Application < Dry::Web::Application
    configure do |config|
      config.routes = 'web/routes'.freeze
      config.container = Container
    end

    route do |r|
      r.multi_route
    end

    load_routes!
  end
end
