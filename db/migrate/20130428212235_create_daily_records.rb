class CreateDailyRecords < ActiveRecord::Migration
  def change
    create_table :daily_records do |t|
      t.integer :user_id
      t.string :message

      t.timestamps
    end
  end
end
