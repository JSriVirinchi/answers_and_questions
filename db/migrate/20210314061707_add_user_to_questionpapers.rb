class AddUserToQuestionpapers < ActiveRecord::Migration[6.0]
  def change
  	add_column :questionpapers, :user_id, :int, foreign_key: true
  end
end
