require 'rails_helper'

RSpec.describe Card, type: :model do
  describe 'Validation' do
    it 'name is necessary' do
      invalid_model = build(:card, name: nil)
      expect(invalid_model.save).to be_falsey
    end

    it 'A card is not related with a column' do
      invalid_model = build(:card, column_id: nil)
      expect(invalid_model.save).to be_falsey
    end

    it 'A card is not related with a project' do
      invalid_model = build(:card, project_id: nil)
      expect(invalid_model.save).to be_falsey
    end
  end

  describe 'instance method' do
    it 'first_column and last_column' do
      project = create(:project)
      first_column = create(:column, project: project)
      middle_column = create(:column, project: project)
      last_column = create(:column, project: project)
      first_columns_card = create(:card, column: first_column)
      middle_columns_card = create(:card, column: middle_column)
      last_columns_card = create(:card, column: last_column)
      _, positions = ColumnPosition.sort_by_sequence_num(project.reload.columns)

      expect(first_columns_card.first_column?(positions)).to be_truthy
      expect(first_columns_card.last_column?(positions)).to be_falsey
      expect(middle_columns_card.first_column?(positions)).to be_falsey
      expect(middle_columns_card.last_column?(positions)).to be_falsey
      expect(last_columns_card.first_column?(positions)).to be_falsey
      expect(last_columns_card.last_column?(positions)).to be_truthy
    end
  end
end
