class CreateQuestionpapers < ActiveRecord::Migration[6.0]
  def change
    create_table :questionpapers do |t|
    	t.string :name
    	t.integer :number_of_questions
    	t.timestamps
    end
  end
end
