class ColumnPosition < ApplicationRecord
  belongs_to :column
  validates :column_id, presence: true
  validates :sequence_num, presence: true

  def change_position(move_to)
    moved_position = ColumnPosition.find(move_to)
    current_sequence_num = sequence_num
    update(sequence_num: moved_position.sequence_num)
    moved_position.update(sequence_num: current_sequence_num)
  end

  def self.add_seq_record_to(column)
    sequence_num_list = column.project.columns.map { |c| c.column_position.sequence_num if c.column_position.present? }
    if sequence_num_list[0].nil?
      max_num = 1
    else
      max_num = sequence_num_list.compact.max
      max_num += 1
    end
    column_position = column.build_column_position
    column_position.column.project_id = column.project_id
    column_position.sequence_num = max_num
  end

  def self.sort_by_sequence_num(columns)
    sorted_columns = columns.sort { |c1, c2| c1.column_position.sequence_num <=> c2.column_position.sequence_num }
    positions = sorted_columns.map(&:column_position)
    [sorted_columns, positions]
  end
end
