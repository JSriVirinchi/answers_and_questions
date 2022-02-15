class AddMarksToQuestionpaper < ActiveRecord::Migration[6.0]
  def change
  	add_column :questionpapers, :total_marks, :decimal
  end
end
