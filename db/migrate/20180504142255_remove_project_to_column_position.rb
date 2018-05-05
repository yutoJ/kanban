class RemoveProjectToColumnPosition < ActiveRecord::Migration[5.1]
  def change
    remove_reference :column_positions, :project, foreign_key: true
  end
end
