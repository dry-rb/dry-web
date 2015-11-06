require 'dummy/view'

module Ui
  module Users
    class Hello < Dummy::View
      configure do |config|
        config.template = 'users/hello'
      end

      def call(scope, locals = {})
        super(scope, users: [{ name: 'Jane' }, { name: 'Joe' }])
      end
    end
  end
end
