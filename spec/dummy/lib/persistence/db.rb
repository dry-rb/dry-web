module Persistence
  class Db
    attr_reader :store

    def initialize
      @store = Hash.new { |k, v| k[v] = [] }
    end

    def [](name)
      store[name]
    end
  end
end
