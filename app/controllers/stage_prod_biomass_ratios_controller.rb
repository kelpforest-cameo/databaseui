class StageProdBiomassRatiosController < ApplicationController
  # GET /stage_prod_biomass_ratios
  # GET /stage_prod_biomass_ratios.json
  def index
    @stage_prod_biomass_ratios = StageProdBiomassRatio.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stage_prod_biomass_ratios }
    end
  end

  # GET /stage_prod_biomass_ratios/1
  # GET /stage_prod_biomass_ratios/1.json
  def show
    @stage_prod_biomass_ratio = StageProdBiomassRatio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage_prod_biomass_ratio }
    end
  end

  # GET /stage_prod_biomass_ratios/new
  # GET /stage_prod_biomass_ratios/new.json
  def new
    @stage_prod_biomass_ratio = StageProdBiomassRatio.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage_prod_biomass_ratio }
    end
  end

  # GET /stage_prod_biomass_ratios/1/edit
  def edit
    @stage_prod_biomass_ratio = StageProdBiomassRatio.find(params[:id])
  end

  # POST /stage_prod_biomass_ratios
  # POST /stage_prod_biomass_ratios.json
  def create
    @stage_prod_biomass_ratio = StageProdBiomassRatio.new(params[:stage_prod_biomass_ratio])

    respond_to do |format|
      if @stage_prod_biomass_ratio.save
        format.html { redirect_to @stage_prod_biomass_ratio, notice: 'Stage prod biomass ratio was successfully created.' }
        format.json { render json: @stage_prod_biomass_ratio, status: :created, location: @stage_prod_biomass_ratio }
      else
        format.html { render action: "new" }
        format.json { render json: @stage_prod_biomass_ratio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stage_prod_biomass_ratios/1
  # PUT /stage_prod_biomass_ratios/1.json
  def update
    @stage_prod_biomass_ratio = StageProdBiomassRatio.find(params[:id])

    respond_to do |format|
      if @stage_prod_biomass_ratio.update_attributes(params[:stage_prod_biomass_ratio])
        format.html { redirect_to @stage_prod_biomass_ratio, notice: 'Stage prod biomass ratio was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage_prod_biomass_ratio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stage_prod_biomass_ratios/1
  # DELETE /stage_prod_biomass_ratios/1.json
  def destroy
    @stage_prod_biomass_ratio = StageProdBiomassRatio.find(params[:id])
    @stage_prod_biomass_ratio.destroy

    respond_to do |format|
      format.html { redirect_to stage_prod_biomass_ratios_url }
      format.json { head :no_content }
    end
  end
end
