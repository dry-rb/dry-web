module Dry
  module Web
    class Parser
      # Regex extracted from dotenv gem
      # https://github.com/bkeepers/dotenv/blob/master/lib/dotenv/parser.rb#L14
      LINE = %r(
        \A
        \s*
        (?:export\s+)?    # optional export
        ([\w\.]+)         # key
        (?:\s*=\s*|:\s+?) # separator
        (                 # optional value begin
          '(?:\'|[^'])*'  #   single quoted value
          |               #   or
          "(?:\"|[^"])*"  #   double quoted value
          |               #   or
          [^#\n]+         #   unquoted value
        )?                # value end
        \s*
        (?:\#.*)?         # optional comment
        \z
      )x

      def self.call(file)
        new(file).parse
      end

      def initialize(file)
        @file = file
        @hash = {}
      end

      def parse
        File.readlines(@file).each do |line|
          parse_line(line)
        end
        @hash
      end

      private

      def parse_line(line)
        if (match = line.match(LINE))
          key, value = match.captures
          @hash[key] = parse_value(value || "")
        end
      end

      def parse_value(value)
        value.strip.sub(/\A(['"])(.*)\1\z/, '\2')
      end
    end
  end
end
