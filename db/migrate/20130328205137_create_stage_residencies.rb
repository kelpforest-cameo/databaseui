class CreateStageResidencies < ActiveRecord::Migration
  def change
    create_table :stage_residencies do |t|
      t.integer :cite_id
      t.integer :stage_id
      t.string :residency
      t.text :comment
      t.string :datum
      t.string :user_id

      t.timestamps
    end
  end
end
