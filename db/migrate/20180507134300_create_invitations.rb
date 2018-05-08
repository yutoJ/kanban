class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations do |t|
      t.integer :invitee_id, null: false
      t.references :project, foreign_key: true, null: false

      t.timestamps
    end
    add_index :invitations, [:invitee_id, :project_id], unique: true
  end
end
