require 'dry/web/container'

module Main
  class Container < Dry::Web::Container
    configure do |config|
      config.root = Pathname(__FILE__).join('../..').realpath.dirname.freeze
      config.auto_register = 'lib'
    end

    require root.join('../../shared/persistence').to_s

    import Persistence::Container

    load_paths!('lib')
  end
end
