require 'rom'
require 'rom-repository'

Dummy::Container.namespace('persistence') do |container|
  ROM.use(:auto_registration)

  ROM.setup(:sql, container.config.app.database_url)

  %w(relations commands).each do |type|
    Dir[container.root.join("lib/persistence/#{type}/**/*.rb")]
      .each(&method(:require))
  end

  container.register('rom', ROM.finalize.container)
end
