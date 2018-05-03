class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.string :name, null: false
      t.references :project, foreign_key: true, null: false
      t.references :column, foreign_key: true, null: false
      t.date :due_date
      t.integer :assignee_id

      t.timestamps
    end

    add_index :cards, [:name, :project_id], unique: true
    add_index :cards, :assignee_id
  end
end
