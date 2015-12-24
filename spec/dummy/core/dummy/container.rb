require 'rodakase/container'

module Dummy
  class Container < Rodakase::Container
    # we need to override default here because we run tests from within the
    # project root and our app is in spec/dummy
    configure do |config|
      config.root = Pathname(__FILE__).dirname.join('../..')
      config.auto_register = 'lib'
    end

    load_paths!('lib')
  end
end
