class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.integer :lft
      t.integer :rgt
      t.integer :parent
      t.integer :active
      t.integer :visible
      t.integer :zoom_min
      t.integer :zoom_max
      t.integer :z_index

      t.timestamps
    end
  end
end
