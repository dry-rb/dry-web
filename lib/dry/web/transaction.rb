require 'dry-transaction'

module Dry
  module Web
    module Transaction
      class Composer
        attr_reader :container

        def initialize(container)
          @container = container
        end

        def define(&block)
          Dry.Transaction(container: container, &block)
        end
      end
    end
  end
end
