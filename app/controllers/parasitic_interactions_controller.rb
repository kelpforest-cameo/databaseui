class ParasiticInteractionsController < ApplicationController
  # GET /parasitic_interactions
  # GET /parasitic_interactions.json
  def index
    @parasitic_interactions = ParasiticInteraction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @parasitic_interactions }
    end
  end

  # GET /parasitic_interactions/1
  # GET /parasitic_interactions/1.json
  def show
    @parasitic_interaction = ParasiticInteraction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @parasitic_interaction }
    end
  end

  # GET /parasitic_interactions/new
  # GET /parasitic_interactions/new.json
  def new
    @parasitic_interaction = ParasiticInteraction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @parasitic_interaction }
    end
  end

  # GET /parasitic_interactions/1/edit
  def edit
    @parasitic_interaction = ParasiticInteraction.find(params[:id])
  end

  # POST /parasitic_interactions
  # POST /parasitic_interactions.json
  def create
    @parasitic_interaction = ParasiticInteraction.new(params[:parasitic_interaction])

    respond_to do |format|
      if @parasitic_interaction.save
        format.html { redirect_to @parasitic_interaction, notice: 'Parasitic interaction was successfully created.' }
        format.json { render json: @parasitic_interaction, status: :created, location: @parasitic_interaction }
      else
        format.html { render action: "new" }
        format.json { render json: @parasitic_interaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /parasitic_interactions/1
  # PUT /parasitic_interactions/1.json
  def update
    @parasitic_interaction = ParasiticInteraction.find(params[:id])

    respond_to do |format|
      if @parasitic_interaction.update_attributes(params[:parasitic_interaction])
        format.html { redirect_to @parasitic_interaction, notice: 'Parasitic interaction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @parasitic_interaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parasitic_interactions/1
  # DELETE /parasitic_interactions/1.json
  def destroy
    @parasitic_interaction = ParasiticInteraction.find(params[:id])
    @parasitic_interaction.destroy

    respond_to do |format|
      format.html { redirect_to parasitic_interactions_url }
      format.json { head :no_content }
    end
  end
end
