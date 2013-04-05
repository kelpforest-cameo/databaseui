class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :first_name
      t.string :last_name
      t.integer :user_id
      t.integer :project_id
      t.boolean :mod
      t.boolean :approved
      
      t.timestamps
    end
  end
end
