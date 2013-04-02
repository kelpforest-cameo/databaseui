class CreateStageMobilities < ActiveRecord::Migration
  def change
    create_table :stage_mobilities do |t|
      t.integer :cite_id
      t.integer :stage_id
      t.string :mobility
      t.text :comment
      t.string :datum
      t.integer :user_id

      t.timestamps
    end
  end
end
