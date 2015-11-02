require 'rodakase/container'

module Dummy
  class Container < Rodakase::Container
    setting :root, Pathname(__FILE__).join('..').realpath.dirname.freeze
    setting :auto_load, true

    configure do |config|
      register(:logger) do
        Logger.new(config.root.join('log/app.log'))
      end

      register(:renderer) do
        Rodakase::Renderer.new(config.root.join('templates'))
      end
    end
  end
end
