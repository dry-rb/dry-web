require "yaml"
require "thread_safe" # FIXME why does dry-validation need me to require this?
require "dry-validation"
require "dry/web/config/struct"

module Dry
  module Web
    class Config
      ConfigNotValidException = Class.new(StandardError)

      attr_reader :schema

      def initialize(&block)
        @schema = Dry::Validation.Form(&block)
      end

      def load(*sources)
        validation = schema.(combine(sources))

        raise ConfigNotValidException, validation.messages if validation.failure?

        Struct.new(validation)
      end

      private

      def combine(sources)
        data = sources.reverse.inject({}) { |memo, source|
          memo.merge(normalize(source))
        }
      end

      def normalize(data)
        data.to_h.map { |k, v| [k.downcase.to_sym, v] }.to_h
      end
    end
  end
end
