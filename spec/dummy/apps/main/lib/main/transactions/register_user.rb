require 'main/import'
require 'main/entities/user'
require 'kleisli'

module Main
  module Transactions
    class RegisterUser
      include Main::Import('persistence.db')

      def call(params)
        if params['name']
          Right(db[:users] << Main::Entities::User.new(*params.values_at('id', 'name')))
        else
          Left(validation: 'name is missing')
        end
      end
    end
  end
end
