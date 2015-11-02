module Persistence
  module Commands
    class CreateUser < ROM::Commands::Create[:sql]
      relation :users
      register_as :create
      result :one
    end
  end
end
