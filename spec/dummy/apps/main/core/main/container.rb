require 'rodakase/container'

module Main
  class Container < Rodakase::Container
    setting :root, Pathname(__FILE__).join('../..').realpath.dirname.freeze
    setting :auto_register, 'lib'

    configure do
      load_paths!('lib')
    end
  end
end
