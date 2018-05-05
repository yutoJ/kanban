class CreateProjectMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :project_members do |t|
      t.integer :member_id, null: false
      t.references :project, foreign_key: true, null: false

      t.timestamps
    end
    add_index :project_members, :member_id
    add_index :project_members, [:member_id, :project_id], unique: true
  end
end
