class CreateRecordUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :name
      t.string :phone_number
      t.string :email

      t.timestamps
    end
  end
end
