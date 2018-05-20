require 'rails_helper'

RSpec.describe ColumnPosition, type: :model do
  let(:column_position) { FactoryBot.create(:column_position) }
  describe 'Validation' do
    it 'column_id is necessary' do
      invalid_model = FactoryBot.build(:column_position, column_id: nil)
      expect(invalid_model.save).to be_falsey
    end

    it 'sequence_num is necessary' do
      invalid_model = FactoryBot.build(:column_position, sequence_num: nil)
      expect(invalid_model.save).to be_falsey
    end
  end
end
