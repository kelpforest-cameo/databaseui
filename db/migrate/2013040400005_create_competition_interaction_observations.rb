class CreateCompetitionInteractionObservations < ActiveRecord::Migration
	def change
		create_table :competition_interaction_observations do |t|
    	t.integer  :citation_id
    	t.integer  :competition_interaction_id
    	t.integer  :location_id
    	t.string   :observation_type
    	t.string   :competition_type
    	t.text     :comment
    	t.string   :datum
    	t.integer  :user_id
    	t.integer  :project_id
    	t.boolean  :mod
    	t.boolean  :approved
    
    	t.timestamps
  	end
	end
end
