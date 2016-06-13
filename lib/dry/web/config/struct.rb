module Dry
  module Web
    class Config
      class Struct
        def initialize(data)
          @data = data.map { |key, val|
            val = val.kind_of?(Hash) ? self.class.new(val) : val
            [key, val]
          }.to_h

          @data.keys.each do |key|
            define_singleton_method(key) do
              @data[key]
            end
          end
        end
      end
    end
  end
end
