class AddQuestionToQuestionpaper < ActiveRecord::Migration[6.0]
  def change
  	add_column :questions, :questionpaper_id, :int, foreign_key: true 
  end
end
