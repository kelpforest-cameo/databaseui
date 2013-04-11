class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :owner
      t.integer :user_id
      t.boolean :public
      t.boolean :approved

      t.timestamps
    end
  end
end
