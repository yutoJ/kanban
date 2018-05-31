require 'rails_helper'

describe ColumnPositionsController do
  describe 'all path' do
    context 'with auth' do
      login
      it 'updates columns position' do
        project = create(:project, user: user)
        left_column = create(:column, project: project)
        pre_left_columns_sequence_num = left_column.column_position.sequence_num
        right_column = create(:column, project: project)
        pre_right_columns_sequence_num = right_column.column_position.sequence_num
        put :update, params: { id: left_column.column_position.id, move_to: right_column.column_position.id }
        expect(left_column.column_position.reload.sequence_num).to eq pre_right_columns_sequence_num
        expect(right_column.column_position.reload.sequence_num).to eq pre_left_columns_sequence_num
      end
    end
  end
end
