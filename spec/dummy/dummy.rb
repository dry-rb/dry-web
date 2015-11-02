require 'rodakase'

class Dummy < Rodakase::Application
  Injection = Dry::AutoInject.new { container(Dummy) }

  def self.AutoInject(*args)
    Injection[*args]
  end

  setting :root, Pathname(__FILE__).dirname
  setting :auto_container, true

  route do |r|
    r.multi_route
  end

  load_routes!
end

require_relative 'config/container'
