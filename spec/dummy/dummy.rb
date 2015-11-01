require 'rodakase'

class Dummy < Rodakase::Application
  setting :root, Pathname(__FILE__).dirname
end

require_relative 'config/container'
