require 'rails_helper'

RSpec.describe ColumnPosition, type: :model do
  let(:column_position) { create(:column_position) }
  describe 'Validation' do
    it 'column_id is necessary' do
      invalid_model = build(:column_position, column_id: nil)
      expect(invalid_model.save).to be_falsey
    end

    it 'sequence_num is necessary' do
      invalid_model = build(:column_position, sequence_num: nil)
      expect(invalid_model.save).to be_falsey
    end
  end

  describe 'class method' do
    it 'add_seq_record_to' do
      project = create(:project)
      columns = Array.new(3) { create(:column, project: project.reload) }
      columns[2].destroy
      next_column = create(:column, project: project.reload)

      expect(columns[0].column_position.sequence_num).to eq 1
      expect(columns[1].column_position.sequence_num).to eq 2
      expect(next_column.column_position.sequence_num).to eq 3
    end

    it 'sort_by_sequence_num' do
      project = create(:project)
      first_column = create(:column, project: project.reload)
      second_column = create(:column, project: project.reload)
      sorted_columns, = ColumnPosition.sort_by_sequence_num([second_column, first_column])
      expect(sorted_columns).to eq [first_column, second_column]
    end
  end

  describe 'instance method' do
    it 'change_position' do
      project = create(:project)
      left_column = create(:column, project: project.reload)
      left_position_sequence_num = left_column.column_position.sequence_num
      right_column = create(:column, project: project.reload)
      right_position_sequence_num = right_column.column_position.sequence_num
      left_column.column_position.change_position(right_column.column_position.id)
      expect(left_column.column_position.reload.sequence_num).to eq right_position_sequence_num
      expect(right_column.column_position.reload.sequence_num).to eq left_position_sequence_num
    end
  end
end
