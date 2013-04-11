class CreateStageLengthWeights < ActiveRecord::Migration
  def change
    create_table :stage_length_weights do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.string :length_weight
      t.decimal :a
      t.decimal :b
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :mod
      t.boolean :approved

      t.timestamps
    end
  end
end
