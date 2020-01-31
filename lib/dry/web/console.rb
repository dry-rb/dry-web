# frozen_string_literal: true

module Dry
  module Web
    class Console
      REPL = begin
               require 'pry'
               Pry
             rescue LoadError
               require 'irb'
               IRB
             end

      def self.start
        REPL.start
      end
    end
  end
end
