class StageBiomassDensitiesController < ApplicationController
  # GET /stage_biomass_densities
  # GET /stage_biomass_densities.json
  def index
    @stage_biomass_densities = StageBiomassDensity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stage_biomass_densities }
    end
  end

  # GET /stage_biomass_densities/1
  # GET /stage_biomass_densities/1.json
  def show
    @stage_biomass_density = StageBiomassDensity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage_biomass_density }
    end
  end

  # GET /stage_biomass_densities/new
  # GET /stage_biomass_densities/new.json
  def new
    @stage_biomass_density = StageBiomassDensity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage_biomass_density }
    end
  end

  # GET /stage_biomass_densities/1/edit
  def edit
    @stage_biomass_density = StageBiomassDensity.find(params[:id])
  end

  # POST /stage_biomass_densities
  # POST /stage_biomass_densities.json
  def create
    @stage_biomass_density = StageBiomassDensity.new(params[:stage_biomass_density])

    respond_to do |format|
      if @stage_biomass_density.save
        format.html { redirect_to @stage_biomass_density, notice: 'Stage biomass density was successfully created.' }
        format.json { render json: @stage_biomass_density, status: :created, location: @stage_biomass_density }
      else
        format.html { render action: "new" }
        format.json { render json: @stage_biomass_density.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stage_biomass_densities/1
  # PUT /stage_biomass_densities/1.json
  def update
    @stage_biomass_density = StageBiomassDensity.find(params[:id])

    respond_to do |format|
      if @stage_biomass_density.update_attributes(params[:stage_biomass_density])
        format.html { redirect_to @stage_biomass_density, notice: 'Stage biomass density was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage_biomass_density.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stage_biomass_densities/1
  # DELETE /stage_biomass_densities/1.json
  def destroy
    @stage_biomass_density = StageBiomassDensity.find(params[:id])
    @stage_biomass_density.destroy

    respond_to do |format|
      format.html { redirect_to stage_biomass_densities_url }
      format.json { head :no_content }
    end
  end
end
