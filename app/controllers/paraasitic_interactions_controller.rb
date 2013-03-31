class ParaasiticInteractionsController < ApplicationController
  # GET /paraasitic_interactions
  # GET /paraasitic_interactions.json
  def index
    @paraasitic_interactions = ParaasiticInteraction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @paraasitic_interactions }
    end
  end

  # GET /paraasitic_interactions/1
  # GET /paraasitic_interactions/1.json
  def show
    @paraasitic_interaction = ParaasiticInteraction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @paraasitic_interaction }
    end
  end

  # GET /paraasitic_interactions/new
  # GET /paraasitic_interactions/new.json
  def new
    @paraasitic_interaction = ParaasiticInteraction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @paraasitic_interaction }
    end
  end

  # GET /paraasitic_interactions/1/edit
  def edit
    @paraasitic_interaction = ParaasiticInteraction.find(params[:id])
  end

  # POST /paraasitic_interactions
  # POST /paraasitic_interactions.json
  def create
    @paraasitic_interaction = ParaasiticInteraction.new(params[:paraasitic_interaction])

    respond_to do |format|
      if @paraasitic_interaction.save
        format.html { redirect_to @paraasitic_interaction, notice: 'Paraasitic interaction was successfully created.' }
        format.json { render json: @paraasitic_interaction, status: :created, location: @paraasitic_interaction }
      else
        format.html { render action: "new" }
        format.json { render json: @paraasitic_interaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /paraasitic_interactions/1
  # PUT /paraasitic_interactions/1.json
  def update
    @paraasitic_interaction = ParaasiticInteraction.find(params[:id])

    respond_to do |format|
      if @paraasitic_interaction.update_attributes(params[:paraasitic_interaction])
        format.html { redirect_to @paraasitic_interaction, notice: 'Paraasitic interaction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @paraasitic_interaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paraasitic_interactions/1
  # DELETE /paraasitic_interactions/1.json
  def destroy
    @paraasitic_interaction = ParaasiticInteraction.find(params[:id])
    @paraasitic_interaction.destroy

    respond_to do |format|
      format.html { redirect_to paraasitic_interactions_url }
      format.json { head :no_content }
    end
  end
end
