class UpdateStages < ActiveRecord::Migration
  def up
   add_column :stages, :citation_id, :integer
  end

  def down
   remove_column :stages, :citation_id, :integer
  end
end
