class CreateStageHabitatDescriptors < ActiveRecord::Migration
  def change
    create_table :stage_habitat_descriptors do |t|
      t.string :descriptor
      t.integer :user_id
      t.integer :project_id
      t.boolean :mod
      t.boolean :approved

      t.timestamps
    end
  end
end
