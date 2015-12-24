require_relative 'dummy/container'

Dummy::Container.finalize!

app_paths = Pathname(__FILE__).dirname.join('../apps').realpath.join('*')
Dir[app_paths].each { |f| require "#{f}/core/boot" }

require_relative "dummy/application"
