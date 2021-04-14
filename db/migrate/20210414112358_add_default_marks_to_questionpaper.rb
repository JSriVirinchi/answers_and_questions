class AddDefaultMarksToQuestionpaper < ActiveRecord::Migration[6.0]
  def change
  	add_column :questionpapers, :default_marks, :decimal
  end
end
