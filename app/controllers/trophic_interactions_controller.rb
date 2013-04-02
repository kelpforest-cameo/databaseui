class TrophicInteractionsController < ApplicationController
  # GET /trophic_interactions
  # GET /trophic_interactions.json
  def index
    @trophic_interactions = TrophicInteraction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trophic_interactions }
    end
  end

  # GET /trophic_interactions/1
  # GET /trophic_interactions/1.json
  def show
    @trophic_interaction = TrophicInteraction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trophic_interaction }
    end
  end

  # GET /trophic_interactions/new
  # GET /trophic_interactions/new.json
  def new
    @trophic_interaction = TrophicInteraction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trophic_interaction }
    end
  end

  # GET /trophic_interactions/1/edit
  def edit
    @trophic_interaction = TrophicInteraction.find(params[:id])
  end

  # POST /trophic_interactions
  # POST /trophic_interactions.json
  def create
    @trophic_interaction = TrophicInteraction.new(params[:trophic_interaction])

    respond_to do |format|
      if @trophic_interaction.save
        format.html { redirect_to @trophic_interaction, notice: 'Trophic interaction was successfully created.' }
        format.json { render json: @trophic_interaction, status: :created, location: @trophic_interaction }
      else
        format.html { render action: "new" }
        format.json { render json: @trophic_interaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trophic_interactions/1
  # PUT /trophic_interactions/1.json
  def update
    @trophic_interaction = TrophicInteraction.find(params[:id])

    respond_to do |format|
      if @trophic_interaction.update_attributes(params[:trophic_interaction])
        format.html { redirect_to @trophic_interaction, notice: 'Trophic interaction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @trophic_interaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trophic_interactions/1
  # DELETE /trophic_interactions/1.json
  def destroy
    @trophic_interaction = TrophicInteraction.find(params[:id])
    @trophic_interaction.destroy

    respond_to do |format|
      format.html { redirect_to trophic_interactions_url }
      format.json { head :no_content }
    end
  end
end
