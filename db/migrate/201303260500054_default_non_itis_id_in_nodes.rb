class DefaultNonItisIdInNodes < ActiveRecord::Migration

def up
change_column :nodes, :non_itis_id, :integer, :null => true, :default => -1
end

def down

end
end
