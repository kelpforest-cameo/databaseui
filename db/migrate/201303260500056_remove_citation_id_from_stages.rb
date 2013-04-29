class RemoveCitationIdFromStages < ActiveRecord::Migration
  def up
    remove_column :stages, :citation_id
  end

  def down
    add_column :stages, :citation_id, :integer
  end
end
