require 'dummy/import'
require 'transaction'

module Transactions
  class RegisterUser < Transaction
    include Dummy::Import('persistence.commands.create_user')

    def call(params)
      if params['name']
        success(create_user.(params))
      else
        failure(:validation, 'name is missing')
      end
    end
  end
end
