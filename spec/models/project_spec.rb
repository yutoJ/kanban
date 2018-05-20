require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { FactoryBot.create(:project) }
  describe 'Validation' do
    it 'name is necessary' do
      invalid_model = FactoryBot.build(:project, name: nil)
      expect(invalid_model.save).to be_falsey
    end

    it 'name character size limit is over' do
      invalid_model = FactoryBot.build(:project, name: 'a' * 141)
      expect(invalid_model.save).to be_falsey
    end

    it 'description character size limit is over' do
      invalid_model = FactoryBot.build(:project, description: 'a' * 301)
      expect(invalid_model.save).to be_falsey
    end

    it 'A project is not related with a user' do
      invalid_model = FactoryBot.build(:project, user_id: nil)
      expect(invalid_model.save).to be_falsey
    end
  end
end
