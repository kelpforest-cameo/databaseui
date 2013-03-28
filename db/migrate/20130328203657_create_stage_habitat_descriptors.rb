class CreateStageHabitatDescriptors < ActiveRecord::Migration
  def change
    create_table :stage_habitat_descriptors do |t|
      t.string :descriptor

      t.timestamps
    end
  end
end
