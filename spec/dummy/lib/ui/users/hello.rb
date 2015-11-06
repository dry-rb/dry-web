require 'dummy/view'

module Ui
  module Users
    class Hello < Dummy::View
      configure do |config|
        config.template = 'users/hello'
      end
    end
  end
end
