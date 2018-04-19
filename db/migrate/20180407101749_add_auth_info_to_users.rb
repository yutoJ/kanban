class AddAuthInfoToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :uid, :string, null: false
    add_column :users, :provider, :string
    add_column :users, :sns_image, :string

    add_index  :users, [:uid, :provider], unique: true
  end
end
