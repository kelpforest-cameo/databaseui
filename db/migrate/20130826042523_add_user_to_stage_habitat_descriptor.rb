class AddUserToStageHabitatDescriptor < ActiveRecord::Migration
  def change
    add_column :stage_habitat_descriptors, :user_id, :integer
  end
end
