RSpec.describe 'Rodakase Application' do
  it 'loads container' do
    expect(Dummy[:logger]).to be_instance_of(Logger)
  end

  it 'auto-loads components' do
    expect(Dummy['entities.user']).to be_instance_of(Entities::User)
  end
end
