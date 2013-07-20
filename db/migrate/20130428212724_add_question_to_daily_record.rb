class AddQuestionToDailyRecord < ActiveRecord::Migration
  def change
    add_column :daily_records, :question_message, :string
    remove_column :daily_records, :message
    add_column :daily_records, :message, :text
  end
end
