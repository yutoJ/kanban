require 'rails_helper'

RSpec.describe Card, type: :model do
  describe 'Validation' do
    it 'name is necessary' do
      invalid_model = FactoryBot.build(:card, name: nil)
      expect(invalid_model.save).to be_falsey
    end

    it 'A card is not related with a column' do
      invalid_model = FactoryBot.build(:card, column_id: nil)
      expect(invalid_model.save).to be_falsey
    end

    it 'A card is not related with a project' do
      invalid_model = FactoryBot.build(:card, project_id: nil)
      expect(invalid_model.save).to be_falsey
    end
  end
end
