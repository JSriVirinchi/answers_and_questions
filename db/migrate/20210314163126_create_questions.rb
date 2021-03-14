class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
    	t.integer :question_number
    	t.decimal :marks
    	t.text :question
    	t.text :solution 
    end
  end
end
