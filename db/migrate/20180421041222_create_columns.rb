class CreateColumns < ActiveRecord::Migration[5.1]
  def change
    create_table :columns do |t|
      t.references :project, foreign_key: true, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :columns, [:name, :project_id], unique: true
  end
end
