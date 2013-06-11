class StageHabitatsController < ApplicationController
  # GET /stage_habitats
  # GET /stage_habitats.json
  def index
    @stage_habitats = StageHabitat.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stage_habitats }
    end
  end

  # GET /stage_habitats/1
  # GET /stage_habitats/1.json
  def show
    @stage_habitat = StageHabitat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage_habitat }
    end
  end

  # GET /stage_habitats/new
  # GET /stage_habitats/new.json
  def new
    @stage_habitat = StageHabitat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage_habitat }
    end
  end

  # GET /stage_habitats/1/edit
  def edit
    @stage_habitat = StageHabitat.find(params[:id])
  end

  # POST /stage_habitats
  # POST /stage_habitats.json
  def create
    @stage_habitat = StageHabitat.new(params[:stage_habitat])

    respond_to do |format|
      if @stage_habitat.save
        format.html { redirect_to @stage_habitat, notice: 'Stage habitat was successfully created.' }
        format.json { render json: @stage_habitat, status: :created, location: @stage_habitat }
      else
        format.html { render action: "new" }
        format.json { render json: @stage_habitat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stage_habitats/1
  # PUT /stage_habitats/1.json
  def update
    @stage_habitat = StageHabitat.find(params[:id])

    respond_to do |format|
      if @stage_habitat.update_attributes(params[:stage_habitat])
        format.html { redirect_to @stage_habitat, notice: 'Stage habitat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage_habitat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stage_habitats/1
  # DELETE /stage_habitats/1.json
  def destroy
    @stage_habitat = StageHabitat.find(params[:id])
    @stage_habitat.destroy

    respond_to do |format|
      format.html { redirect_to stage_habitats_url }
      format.json { head :no_content }
    end
  end
end
