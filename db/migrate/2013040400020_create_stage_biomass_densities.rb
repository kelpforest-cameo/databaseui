class CreateStageBiomassDensities < ActiveRecord::Migration
  def change
    create_table :stage_biomass_densities do |t|
      t.integer :citation_id
      t.integer :stage_id
      t.decimal :biomass_density
      t.text :comment
      t.string :datum
      t.integer :user_id
      t.integer :project_id
      t.boolean :mod
      t.boolean :approved

      t.timestamps
    end
  end
end
