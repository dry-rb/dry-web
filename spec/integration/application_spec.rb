require 'entities/user'

RSpec.describe 'Rodakase Application' do
  it 'loads container' do
    expect(Dummy::Application[:logger]).to be_instance_of(Logger)
  end

  it 'auto-loads components' do
    expect(Dummy::Application['entities.user']).to be_instance_of(Entities::User)
  end

  it 'sets up auto-injection mechanism' do
    klass = Class.new { include Dummy::Import(:logger) }

    expect(klass.new.logger).to be_instance_of(Logger)
  end
end
