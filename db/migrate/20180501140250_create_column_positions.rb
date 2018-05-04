class CreateColumnPositions < ActiveRecord::Migration[5.1]
  def change
    create_table :column_positions do |t|
      t.references :project, foreign_key: true, null: false
      t.references :column, foreign_key: true, null: false
      t.integer :sequence_num, null: false

      t.timestamps
    end
  end
end
