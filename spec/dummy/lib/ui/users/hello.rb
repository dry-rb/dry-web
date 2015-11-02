module Ui
  module Users
    class Hello
      include Dummy::AutoInject(:renderer)

      def call
        renderer.call('users/hello.slim')
      end
    end
  end
end
