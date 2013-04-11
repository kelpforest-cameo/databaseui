class CreateParasiticInteractionObservations < ActiveRecord::Migration
  def change
    create_table :parasitic_interaction_observations do |t|
    	t.integer  :citation_id
    	t.integer  :parasitic_interaction_id
    	t.integer  :location_id
    	t.string   :endo_ecto
    	t.string   :lethality
    	t.decimal    :prevalence
    	t.decimal    :intensity
    	t.string   :parasite_type
    	t.string   :observation_type
    	t.text     :comment
    	t.string   :datum
    	t.integer  :user_id
    	t.integer :project_id
    	t.boolean :mod
    	t.boolean :approved
    	
    	t.timestamps
    end
  end
end
