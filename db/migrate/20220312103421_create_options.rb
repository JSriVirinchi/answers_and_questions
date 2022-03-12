class CreateOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :options do |t|
      t.text :option
      t.boolean :answer
    end
  end
end
