class FacilitationInterationObservationsController < ApplicationController
  # GET /facilitation_interation_observations
  # GET /facilitation_interation_observations.json
  def index
    @facilitation_interation_observations = FacilitationInterationObservation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @facilitation_interation_observations }
    end
  end

  # GET /facilitation_interation_observations/1
  # GET /facilitation_interation_observations/1.json
  def show
    @facilitation_interation_observation = FacilitationInterationObservation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @facilitation_interation_observation }
    end
  end

  # GET /facilitation_interation_observations/new
  # GET /facilitation_interation_observations/new.json
  def new
    @facilitation_interation_observation = FacilitationInterationObservation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @facilitation_interation_observation }
    end
  end

  # GET /facilitation_interation_observations/1/edit
  def edit
    @facilitation_interation_observation = FacilitationInterationObservation.find(params[:id])
  end

  # POST /facilitation_interation_observations
  # POST /facilitation_interation_observations.json
  def create
    @facilitation_interation_observation = FacilitationInterationObservation.new(params[:facilitation_interation_observation])

    respond_to do |format|
      if @facilitation_interation_observation.save
        format.html { redirect_to @facilitation_interation_observation, notice: 'Facilitation interation observation was successfully created.' }
        format.json { render json: @facilitation_interation_observation, status: :created, location: @facilitation_interation_observation }
      else
        format.html { render action: "new" }
        format.json { render json: @facilitation_interation_observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /facilitation_interation_observations/1
  # PUT /facilitation_interation_observations/1.json
  def update
    @facilitation_interation_observation = FacilitationInterationObservation.find(params[:id])

    respond_to do |format|
      if @facilitation_interation_observation.update_attributes(params[:facilitation_interation_observation])
        format.html { redirect_to @facilitation_interation_observation, notice: 'Facilitation interation observation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @facilitation_interation_observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facilitation_interation_observations/1
  # DELETE /facilitation_interation_observations/1.json
  def destroy
    @facilitation_interation_observation = FacilitationInterationObservation.find(params[:id])
    @facilitation_interation_observation.destroy

    respond_to do |format|
      format.html { redirect_to facilitation_interation_observations_url }
      format.json { head :no_content }
    end
  end
end
