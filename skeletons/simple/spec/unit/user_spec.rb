require 'main/entities/user'

RSpec.describe Main::Entities::User do
  subject(:user) { Main::Entities::User.new(1, 'Jane') }

  describe '#id' do
    it 'works' do
      expect(user.id).to be(1)
    end
  end

  describe '#name' do
    it 'works too' do
      expect(user.name).to eql('Jane')
    end
  end
end
