class AddAcceptToProjectMember < ActiveRecord::Migration[5.1]
  def change
    add_column :project_members, :accept, :boolean, default: false
  end
end
