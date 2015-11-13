require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)
task default: [:spec]

require_relative 'spec/dummy/core/dummy/container'
require 'rom/sql/rake_task'

namespace :db do
  task :setup do
    Dummy::Container.boot!(:rom)
  end
end
