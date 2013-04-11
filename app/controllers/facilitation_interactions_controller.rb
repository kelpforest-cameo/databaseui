class FacilitationInteractionsController < ApplicationController
  # GET /facilitation_interactions
  # GET /facilitation_interactions.json
  def index
    @facilitation_interactions = FacilitationInteraction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @facilitation_interactions }
    end
  end

  # GET /facilitation_interactions/1
  # GET /facilitation_interactions/1.json
  def show
    @facilitation_interaction = FacilitationInteraction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @facilitation_interaction }
    end
  end

  # GET /facilitation_interactions/new
  # GET /facilitation_interactions/new.json
  def new
    @facilitation_interaction = FacilitationInteraction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @facilitation_interaction }
    end
  end

  # GET /facilitation_interactions/1/edit
  def edit
    @facilitation_interaction = FacilitationInteraction.find(params[:id])
  end

  # POST /facilitation_interactions
  # POST /facilitation_interactions.json
  def create
    @facilitation_interaction = FacilitationInteraction.new(params[:facilitation_interaction])

    respond_to do |format|
      if @facilitation_interaction.save
        format.html { redirect_to @facilitation_interaction, notice: 'Facilitation interaction was successfully created.' }
        format.json { render json: @facilitation_interaction, status: :created, location: @facilitation_interaction }
      else
        format.html { render action: "new" }
        format.json { render json: @facilitation_interaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /facilitation_interactions/1
  # PUT /facilitation_interactions/1.json
  def update
    @facilitation_interaction = FacilitationInteraction.find(params[:id])

    respond_to do |format|
      if @facilitation_interaction.update_attributes(params[:facilitation_interaction])
        format.html { redirect_to @facilitation_interaction, notice: 'Facilitation interaction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @facilitation_interaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facilitation_interactions/1
  # DELETE /facilitation_interactions/1.json
  def destroy
    @facilitation_interaction = FacilitationInteraction.find(params[:id])
    @facilitation_interaction.destroy

    respond_to do |format|
      format.html { redirect_to facilitation_interactions_url }
      format.json { head :no_content }
    end
  end
end
