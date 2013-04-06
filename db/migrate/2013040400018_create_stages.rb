class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
    	t.string :name
      t.integer :node_id
      t.integer :user_id
      t.integer :project_id
      t.boolean :mod
      t.boolean :approved

      t.timestamps
    end
  end
end
