require 'main/import'
require 'main/entities/user'
require 'transaction'

module Main
  module Transactions
    class RegisterUser < Transaction
      include Main::Import('persistence.db')

      def call(params)
        if params['name']
          success(db[:users] << Main::Entities::User.new(*params.values_at('id', 'name')))
        else
          failure(:validation, 'name is missing')
        end
      end
    end
  end
end
