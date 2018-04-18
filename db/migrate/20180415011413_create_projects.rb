class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.text :description
      t.integer :host_user_id, null: false

      t.timestamps
    end

    add_index :projects, :host_user_id
  end
end
