require 'dry/web/container'

module Simple
  class Container < Dry::Web::Container
    setting :auto_register, 'lib'

    configure do
      load_paths!('lib')
    end
  end
end
