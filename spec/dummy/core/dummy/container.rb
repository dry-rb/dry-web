require 'rodakase/container'

module Dummy
  class Container < Rodakase::Container
    # we need to override default here because we run tests from within the
    # project root and our app is in spec/dummy
    setting :root, Pathname(__FILE__).dirname.join('../..')

    load_paths!('lib')
  end
end
