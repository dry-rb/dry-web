Dummy::Container.namespace('persistence') do |container|
  container.register('rom') do
    return ROM.container if ROM.container

    ROM.use(:auto_registration)

    ROM.setup(:sql, 'postgres://localhost/rodakase')

    %w(relations commands).each do |type|
      Dir[container.root.join("persistence/#{type}/**/*.rb")].each(&method(:require))
    end

    ROM.finalize.container
  end
end
