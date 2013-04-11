class AddProjectIdToFunctionalGroups < ActiveRecord::Migration
  def change
    add_column :functional_groups, :project_id, :integer
    add_column :functional_groups, :user_id, :integer
    add_column :functional_groups, :mod, :boolean
    add_column :functional_groups, :approved, :boolean
  end
end
