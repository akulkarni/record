class RenameEncryptedPasswordToPasswordHashInRecordUser < ActiveRecord::Migration
  def change
    rename_column :users, :encrypted_password, :password_hash
  end
end
