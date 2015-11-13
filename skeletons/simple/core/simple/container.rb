require 'rodakase/container'

module Simple
  class Container < Rodakase::Container
    setting :auto_register, 'lib'

    configure do
      load_paths!('lib')
    end
  end
end
