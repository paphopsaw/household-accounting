class AddProfileToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :text
    add_column :users, :auth_token, :text
    add_index :users, :auth_token, unique: true
  end
end
