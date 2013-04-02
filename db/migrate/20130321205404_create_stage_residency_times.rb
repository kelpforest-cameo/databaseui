class CreateStageResidencyTimes < ActiveRecord::Migration
  def change
    create_table :stage_residency_times do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.float :residency_time
      t.text :comment
      t.string :datum
      t.integer :user_id

      t.timestamps
    end
  end
end