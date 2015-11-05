require 'rom'

Dummy::Container.namespace('persistence') do |container|
  container.register('rom') do
    # TODO: extend container with memoization support
    if ROM.container
      ROM.container
    else
      ROM.use(:auto_registration)

      ROM.setup(:sql, 'postgres://localhost/rodakase')

      %w(relations commands).each do |type|
        Dir[container.root.join("lib/persistence/#{type}/**/*.rb")]
          .each(&method(:require))
      end

      ROM.finalize.container
    end
  end
end
