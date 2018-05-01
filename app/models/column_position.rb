class ColumnPosition < ApplicationRecord
  belongs_to :project
  belongs_to :column

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
end
