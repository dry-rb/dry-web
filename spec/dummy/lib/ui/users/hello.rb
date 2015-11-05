require 'dummy/import'

module Ui
  module Users
    class Hello
      include Dummy::Import(:renderer)

      def call
        renderer.call('users/hello.slim')
      end
    end
  end
end
