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
  end
end
