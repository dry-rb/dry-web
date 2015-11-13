# set the env here since the app config loaded by container uses this name by
# default
ENV['RACK_ENV'] = 'test'

# Only load the container, if a test needs the whole web stack it should require
# web_helper instead
require_relative '../core/simple/container'

RSpec.configure do |config|
  # Obviously
  config.disable_monkey_patching!
end
