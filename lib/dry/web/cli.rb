module Dry
  module Web
    class Cli
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
