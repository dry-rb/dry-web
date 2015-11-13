require 'main/import'
require 'entities/user'
require 'transaction'

module Transactions
  class RegisterUser < Transaction
    include Main::Import(:db)

    def call(params)
      if params['name']
        success(db[:users] << Entities::User.new(*params.values_at('id', 'name')))
      else
        failure(:validation, 'name is missing')
      end
    end
  end
end
