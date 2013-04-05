class CreateNonItis < ActiveRecord::Migration
  def change
    create_table :non_itis do |t|
      t.integer :parent_id
      t.string :latin_name
      t.string :taxonomy_level
      t.boolean :parent_id_is_itis
      t.text :info
      t.integer :user_id
      t.integer :project_id
      t.boolean :mod
      t.boolean :approved

      t.timestamps
    end
  end
end
