class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.text :description
      t.references :user, null: false

      t.timestamps
    end
  end
end
