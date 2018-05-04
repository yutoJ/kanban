class ColumnPosition < ApplicationRecord
  belongs_to :project
  belongs_to :column

  def change_position(move_to)
    moved_position = ColumnPosition.find(move_to)
    current_sequence_num = sequence_num
    update(sequence_num: moved_position.sequence_num)
    moved_position.update(sequence_num: current_sequence_num)
  end

  def self.add_seq_record_to(column)
    max_num = ColumnPosition.where(project_id: column.project_id).maximum(:sequence_num)
    if max_num.nil?
      max_num = 1
    else
      max_num += 1
    end
    column_position = column.build_column_position
    column_position.project_id = column.project_id
    column_position.sequence_num = max_num
  end

  def self.select_columns_related_with(project)
    positions = project.column_positions.order(:sequence_num)
    column_ids = positions.map(&:column_id)
    [Column.find(column_ids), positions]
  end
end
