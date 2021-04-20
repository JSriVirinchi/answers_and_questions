class CreateSchool < ActiveRecord::Migration[6.0]
  def change
    create_table :schools do |t|
		t.string :name
    	t.text :address
    	t.text :description
    	t.string :phone
    	t.timestamps    	
    end
  end
end
