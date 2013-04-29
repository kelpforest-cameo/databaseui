class AddCitationIdColumns < ActiveRecord::Migration
  def up
  	add_column :stages, :citation_id, :integer, :null => false
  	
  end

  def down
  remove_column :stages, :citation_id, :integer, :null => false
  end
end
