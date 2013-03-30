class CreateStageConsumeBiomassRatios < ActiveRecord::Migration
  def change
    create_table :stage_consume_biomass_ratios do |t|
      t.integer :cite_id
      t.integer :stage_id
      t.decimal :consume_biomass_ratio
      t.text :comment
      t.string :datum
      t.integer :user_id

      t.timestamps
    end
  end
end
