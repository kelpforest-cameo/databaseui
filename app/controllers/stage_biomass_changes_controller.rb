class StageBiomassChangesController < ApplicationController
  # GET /stage_biomass_changes
  # GET /stage_biomass_changes.json
  def index
    @stage_biomass_changes = StageBiomassChange.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stage_biomass_changes }
    end
  end

  # GET /stage_biomass_changes/1
  # GET /stage_biomass_changes/1.json
  def show
    @stage_biomass_change = StageBiomassChange.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage_biomass_change }
    end
  end

  # GET /stage_biomass_changes/new
  # GET /stage_biomass_changes/new.json
  def new
    @stage_biomass_change = StageBiomassChange.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage_biomass_change }
    end
  end

  # GET /stage_biomass_changes/1/edit
  def edit
    @stage_biomass_change = StageBiomassChange.find(params[:id])
  end

  # POST /stage_biomass_changes
  # POST /stage_biomass_changes.json
  def create
    @stage_biomass_change = StageBiomassChange.new(params[:stage_biomass_change])

    respond_to do |format|
      if @stage_biomass_change.save
        format.html { redirect_to @stage_biomass_change, notice: 'Stage biomass change was successfully created.' }
        format.json { render json: @stage_biomass_change, status: :created, location: @stage_biomass_change }
      else
        format.html { render action: "new" }
        format.json { render json: @stage_biomass_change.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stage_biomass_changes/1
  # PUT /stage_biomass_changes/1.json
  def update
    @stage_biomass_change = StageBiomassChange.find(params[:id])

    respond_to do |format|
      if @stage_biomass_change.update_attributes(params[:stage_biomass_change])
        format.html { redirect_to @stage_biomass_change, notice: 'Stage biomass change was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage_biomass_change.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stage_biomass_changes/1
  # DELETE /stage_biomass_changes/1.json
  def destroy
    @stage_biomass_change = StageBiomassChange.find(params[:id])
    @stage_biomass_change.destroy

    respond_to do |format|
      format.html { redirect_to stage_biomass_changes_url }
      format.json { head :no_content }
    end
  end
end
