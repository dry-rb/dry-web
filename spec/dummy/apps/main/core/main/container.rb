require 'rodakase/container'

module Main
  class Container < Rodakase::Container
    configure do |config|
      config.root = Pathname(__FILE__).join('../..').realpath.dirname.freeze
      config.auto_register = 'lib'
    end

    load_paths!('lib')
  end
end
