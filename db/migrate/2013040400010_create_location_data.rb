class CreateLocationData < ActiveRecord::Migration
  def change
    create_table :location_data do |t|
      t.float :latitude
      t.float :longitude
      t.integer :location_id
      t.string :name
      t.integer :user_id
      t.integer :project_id
      t.boolean :mod
      t.boolean :approved

      t.timestamps
    end
  end
end
