require 'logger'
require 'rodakase/container'
require 'rodakase/renderer'

require 'dry/data'
require 'rom-sql'
require 'rom-repository'

module Dummy
  class Container < Rodakase::Container
    setting :root, Pathname(__FILE__).join('..').realpath.dirname.freeze
    setting :auto_load, true

    $LOAD_PATH.unshift(root.join('lib').to_s)

    configure do |container|
      register(:logger) do
        Logger.new(container.root.join('log/app.log'))
      end

      register(:renderer) do
        Rodakase::Renderer.new(container.root.join('templates'))
      end
    end
  end
end
