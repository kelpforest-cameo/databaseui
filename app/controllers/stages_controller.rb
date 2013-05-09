class StagesController < ApplicationController

	#For saving/creating stage values/tables
	def stage_save 
		@stage_id = Stage.where(:name => params[:stage][:name],:node_id =>params[:stage][:node_id]).first.id
		params[:stage] = params[:stage].merge(:project_id => current_user.project_id,:user_id => current_user.id)	
		params[:stage].delete(:name)
		params[:stage].delete(:node_id)
		params[:stage] = params[:stage].merge(:stage_id => @stage_id)
		if current_user.role == 'admin' || current_user.role == 'moderator'
			params[:stage] = params[:stage].merge(:approved => true,:mod => true)
		else
			params[:stage] = params[:stage].merge(:approved => true,:mod => false)
		end
		params[:stage] = params[:stage].merge(:datum => "")
		params[:stage] = params[:stage].merge(:biomass_change => params[:biomass_change])
		@stage_biomass_change = StageBiomassChange.new(params[:stage])
		params[:stage].delete(:biomass_change)
		
		params[:stage] = params[:stage].merge(:biomass_density => params[:biomass_density])
		@stage_biomass_density = StageBiomassDensity.new(params[:stage])
		params[:stage].delete(:biomass_density)
		
		params[:stage] = params[:stage].merge(:consum_biomass_ratio => params[:consum_biomass_ratio])
		@stage_consum_biomass_ratio = StageConsumBiomassRatio.new(params[:stage])
		params[:stage].delete(:consum_biomass_ratio)
		
		params[:stage] = params[:stage].merge(:consumer_strategy => params[:consumer_strategy])
		@stage_consumer_strategy = StageConsumerStrategy.new(params[:stage])
		params[:stage].delete(:consumer_strategy)
		
		params[:stage] = params[:stage].merge(:drymass => params[:drymass])
		@stage_drymass = StageDrymass.new(params[:stage])
		params[:stage].delete(:drymass)
		
		params[:stage] = params[:stage].merge(:duration => params[:duration])
		@stage_duration = StageDuration.new(params[:stage])
		params[:stage].delete(:duration)
		
		params[:stage] = params[:stage].merge(:fecundity => params[:fecundity])
		@stage_fecundity = StageFecundity.new(params[:stage])
		params[:stage].delete(:fecundity)
		
		#@stage_habitat = StageHabitat.new(params[:stage])
		
		params[:stage] = params[:stage].merge(:length => params[:length])
		@stage_length = StageLength.new(params[:stage])
		params[:stage].delete(:length)
		
		#@stage_length_fecundity = StageLengthFecundity.new(params[:stage],params[:stage_length_fecundity])
		#@stage_length_weight = StageLengthWeight.new(params[:stage],params[:stage_length_weight])
		
		params[:stage] = params[:stage].merge(:lifestyle => params[:lifestyle])
		@stage_lifestyle = StageLifestyle.new(params[:stage])
		params[:stage].delete(:lifestyle)
		
		params[:stage] = params[:stage].merge(:mass => params[:mass])
		@stage_mass = StageMass.new(params[:stage])
		params[:stage].delete(:mass)
		
		params[:stage] = params[:stage].merge(:max_depth => params[:max_depth])
		@stage_max_depth = StageMaxDepth.new(params[:stage])
		params[:stage].delete(:max_depth)
		
		params[:stage] = params[:stage].merge(:mobility => params[:mobility])
		@stage_mobility = StageMobility.new(params[:stage])
		params[:stage].delete(:mobility)
		
		params[:stage] = params[:stage].merge(:population => params[:population])
		@stage_population = StagePopulation.new(params[:stage])
		params[:stage].delete(:population)
		
		params[:stage] = params[:stage].merge(:prod_biomass_ratio => params[:prod_biomass_ratio])
		@stage_prod_biomass_ratio = StageProdBiomassRatio.new(params[:stage])
		params[:stage].delete(:prod_biomass_ratio)
		
		params[:stage] = params[:stage].merge(:prod_consum_ratio => params[:prod_consum_ratio])
		@stage_prod_consum_ratio = StageProdConsumRatio.new(params[:stage])
		params[:stage].delete(:prod_consum_ratio)
		
		params[:stage] = params[:stage].merge(:reproductive_strategy => params[:reproductive_strategy])
		@stage_reproductive_strategy = StageReproductiveStrategy.new(params[:stage])
		params[:stage].delete(:reproductive_strategy)
		
		params[:stage] = params[:stage].merge(:residency => params[:residency])
		@stage_residency = StageResidency.new(params[:stage])
		params[:stage].delete(:residency)
		
		params[:stage] = params[:stage].merge(:residency_time => params[:residency_time])
		@stage_residency_time = StageResidencyTime.new(params[:stage])
		params[:stage].delete(:residency_time)
		
		params[:stage] = params[:stage].merge(:unassimilated_consum_ratio => params[:unassimilated_consum_ratio])
		@stage_unassimilated_consum_ratio = StageUnassimilatedConsumRatio.new(params[:stage])
		params[:stage].delete(:unassimilated_consum_ratio)
		
		@stage_biomass_change.save
		@stage_biomass_density.save
		@stage_consum_biomass_ratio.save
		@stage_consumer_strategy.save
		@stage_drymass.save
		@stage_duration.save
		@stage_fecundity.save
		#@stage_habitat.save
		@stage_length.save
		#@stage_length_fecundity.save
		#@stage_length_weight.save
		@stage_lifestyle.save
		@stage_mass.save
		@stage_max_depth.save
		@stage_mobility.save
		@stage_population.save
		@stage_prod_biomass_ratio.save
		@stage_prod_consum_ratio.save
		@stage_reproductive_strategy.save
		@stage_residency.save
		@stage_residency_time.save
		@stage_unassimilated_consum_ratio.save
		render :nothing => true
	end


	#returns html for a stage_form
	def stage_form	
		
		render :partial => 'dashboard/stage_form'
	end

	#For creating stage in interactions
	def create_stage
		params[:stage] = params[:stage].merge(:project_id => current_user.project_id,:user_id => current_user.id)	
		if current_user.role == 'admin' || current_user.role == 'moderator'
			params[:stage] = params[:stage].merge(:approved => true,:mod => true)
		else
			params[:stage] = params[:stage].merge(:approved => true,:mod => false)
		end
		#Create new entries
		params[:stage].delete(:citation_id)
		@stage = Stage.new(params[:stage])
		@stage.save
		render :nothing => true
	end

  #For populating interaction select
  def search_stage
	@stage_array = ["general", "adult", "juvenile","larval","egg","sporophyte","gametophyte","dead"]
	@result = []
	puts params[:node]
	@stage_array.each do |a|
		if Stage.where(:name => a, :node_id => params[:node]).exists?
			@result << (a)
		else
			@result << (a + " *")
		end
	end
	render :json => [@stage_array,@result]
  end
  # GET /stages11
  # GET /stages.json
  def index
    @stages = Stage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stages }
    end
  end

  # GET /stages/1
  # GET /stages/1.json
  def show
    @stage = Stage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage }
    end
  end

  # GET /stages/new
  # GET /stages/new.json
  def new
    @stage = Stage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage }
    end
  end

  # GET /stages/1/edit
  def edit
    @stage = Stage.find(params[:id])
  end

  # POST /stages
  # POST /stages.json
  def create
    @stage = Stage.new(params[:stage])

    respond_to do |format|
      if @stage.save
        format.html { redirect_to @stage, notice: 'Stage was successfully created.' }
        format.json { render json: @stage, status: :created, location: @stage }
      else
        format.html { render action: "new" }
        format.json { render json: @stage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stages/1
  # PUT /stages/1.json
  def update
    @stage = Stage.find(params[:id])

    respond_to do |format|
      if @stage.update_attributes(params[:stage])
        format.html { redirect_to @stage, notice: 'Stage was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stages/1
  # DELETE /stages/1.json
  def destroy
    @stage = Stage.find(params[:id])
    @stage.destroy

    respond_to do |format|
      format.html { redirect_to stages_url }
      format.json { head :no_content }
    end
  end
end
