require 'rom'
require 'rom-repository'

Dummy::Container.namespace('persistence') do |container|
  ROM.use(:auto_registration)
  ROM.setup(:sql, container.config.app.database_url)

  %w(relations commands).each do |type|
    container.require("lib/persistence/#{type}/**/*.rb")
  end

  container.register('rom', ROM.finalize.container)

  container.require('core/container/persistence')
end
