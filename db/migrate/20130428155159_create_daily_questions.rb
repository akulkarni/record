class CreateDailyQuestions < ActiveRecord::Migration
  def change
    create_table :daily_questions do |t|
      t.string :message

      t.timestamps
    end
  end
end
