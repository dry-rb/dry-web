require 'rodakase'

class Dummy < Rodakase::Application
  setting :root, Pathname(__FILE__).dirname
  setting :auto_container, true

  route do |r|
    r.multi_route
  end

  load_routes!
end

require_relative 'config/container'
