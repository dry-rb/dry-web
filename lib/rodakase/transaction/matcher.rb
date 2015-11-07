module Rodakase
  module Transaction
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
  end
end
