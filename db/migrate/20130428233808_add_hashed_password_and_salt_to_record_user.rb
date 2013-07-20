class AddHashedPasswordAndSaltToRecordUser < ActiveRecord::Migration
  def change
    remove_column :users, :password
    add_column :users, :encrypted_password, :string
    add_column :users, :password_salt, :string
  end
end
