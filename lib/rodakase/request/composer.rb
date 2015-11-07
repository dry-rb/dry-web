require 'transflow'

module Rodakase
  module Transaction
    class Success
      attr_reader :value

      def initialize(value)
        @value = value
      end

      def fmap
        Success.new(yield(value))
      end

      def success?
        true
      end

      def failure?
        false
      end
    end

    class Failure
      attr_reader :code, :error
      alias_method :value, :error

      def initialize(*args)
        @code, @error = args
      end

      def fmap
        self
      end

      def success?
        false
      end

      def failure?
        true
      end
    end

    def self.Failure(code, error)
      Failure.new(code, error)
    end

    def self.Success(value)
      Success.new(value)
    end

    class Matcher
      attr_reader :result

      class Error
        attr_reader :result

        def initialize(result)
          @result = result
        end

        def on(code, &block)
          yield(result.value) if result.code == code
        end
      end

      def initialize(result)
        @result = result
      end

      def success(&block)
        yield(result.value) if result.success?
      end

      def failure(&block)
        yield(Error.new(result)) if result.failure?
      end
    end

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
