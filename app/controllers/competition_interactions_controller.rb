class CompetitionInteractionsController < ApplicationController
  # GET /competition_interactions
  # GET /competition_interactions.json
  def index
    @competition_interactions = CompetitionInteraction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @competition_interactions }
    end
  end

  # GET /competition_interactions/1
  # GET /competition_interactions/1.json
  def show
    @competition_interaction = CompetitionInteraction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @competition_interaction }
    end
  end

  # GET /competition_interactions/new
  # GET /competition_interactions/new.json
  def new
    @competition_interaction = CompetitionInteraction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @competition_interaction }
    end
  end

  # GET /competition_interactions/1/edit
  def edit
    @competition_interaction = CompetitionInteraction.find(params[:id])
  end

  # POST /competition_interactions
  # POST /competition_interactions.json
  def create
    @competition_interaction = CompetitionInteraction.new(params[:competition_interaction])

    respond_to do |format|
      if @competition_interaction.save
        format.html { redirect_to @competition_interaction, notice: 'Competition interaction was successfully created.' }
        format.json { render json: @competition_interaction, status: :created, location: @competition_interaction }
      else
        format.html { render action: "new" }
        format.json { render json: @competition_interaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /competition_interactions/1
  # PUT /competition_interactions/1.json
  def update
    @competition_interaction = CompetitionInteraction.find(params[:id])

    respond_to do |format|
      if @competition_interaction.update_attributes(params[:competition_interaction])
        format.html { redirect_to @competition_interaction, notice: 'Competition interaction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @competition_interaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /competition_interactions/1
  # DELETE /competition_interactions/1.json
  def destroy
    @competition_interaction = CompetitionInteraction.find(params[:id])
    @competition_interaction.destroy

    respond_to do |format|
      format.html { redirect_to competition_interactions_url }
      format.json { head :no_content }
    end
  end
end
