require 'rodakase'

class Dummy < Rodakase::Application
  setting :root, Pathname(__FILE__).dirname
  setting :auto_container, true
end

require_relative 'config/container'
