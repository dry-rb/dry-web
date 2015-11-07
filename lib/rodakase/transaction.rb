require 'transflow'

require 'rodakase/transaction/result'
require 'rodakase/transaction/matcher'

module Rodakase
  module Transaction
    class Flow
      attr_reader :transaction

      def initialize(transaction)
        @transaction = transaction
      end

      def call(*args, &block)
        yield(Matcher.new(transaction.call(*args)))
      end
    end

    class Composer
      attr_reader :container

      def initialize(container)
        @container = container
      end

      def define(&block)
        Flow.new(Transflow(container: container, &block))
      end
    end
  end
end
