require 'rom'
require 'rom-repository'

Dummy::Container.namespace('persistence') do |container|
  container.register('rom') do
    # TODO: extend container with memoization support
    if ROM.container
      ROM.container
    else
      ROM.use(:auto_registration)

      ROM.setup(:sql, container.config.app.database_url)

      %w(relations commands).each do |type|
        Dir[container.root.join("lib/persistence/#{type}/**/*.rb")]
          .each(&method(:require))
      end

      ROM.finalize.container
    end
  end

  container.auto_load!(container.root.join('lib/persistence/repositories')) do |repo_class|
    -> { Inflecto.constantize(repo_class).new(container['persistence.rom']) }
  end
end
