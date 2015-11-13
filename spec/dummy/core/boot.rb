require_relative 'dummy/container'

Dummy::Container.finalize! do |container|
  require 'logger'
  container.register(:logger, Logger.new(container.root.join('log/app.log')))

  require 'rodakase/transaction'
  container.register(:transaction, Rodakase::Transaction::Composer.new(container))

  require 'persistence/db'
  container.register(:db, Persistence::Db.new)
end

app_paths = Pathname(__FILE__).dirname.join('../apps').realpath.join('*')
Dir[app_paths].each { |f| require "#{f}/core/boot" }
