class AddQuestionToOption < ActiveRecord::Migration[6.0]
  def change
    add_column :options, :question_id, :int, foreign_key: true
  end
end
