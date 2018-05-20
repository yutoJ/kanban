require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  describe 'Validation' do
    it 'name is necessary' do
      invalid_model = FactoryBot.build(:user, name: nil)
      expect(invalid_model.save).to be_falsey
    end

    it 'uid is necessary' do
      invalid_model = FactoryBot.build(:user, uid: nil)
      expect(invalid_model.save).to be_falsey
    end
  end
end
