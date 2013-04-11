class StagePopulationsController < ApplicationController
  # GET /stage_populations
  # GET /stage_populations.json
  def index
    @stage_populations = StagePopulation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stage_populations }
    end
  end

  # GET /stage_populations/1
  # GET /stage_populations/1.json
  def show
    @stage_population = StagePopulation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage_population }
    end
  end

  # GET /stage_populations/new
  # GET /stage_populations/new.json
  def new
    @stage_population = StagePopulation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage_population }
    end
  end

  # GET /stage_populations/1/edit
  def edit
    @stage_population = StagePopulation.find(params[:id])
  end

  # POST /stage_populations
  # POST /stage_populations.json
  def create
    @stage_population = StagePopulation.new(params[:stage_population])

    respond_to do |format|
      if @stage_population.save
        format.html { redirect_to @stage_population, notice: 'Stage population was successfully created.' }
        format.json { render json: @stage_population, status: :created, location: @stage_population }
      else
        format.html { render action: "new" }
        format.json { render json: @stage_population.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stage_populations/1
  # PUT /stage_populations/1.json
  def update
    @stage_population = StagePopulation.find(params[:id])

    respond_to do |format|
      if @stage_population.update_attributes(params[:stage_population])
        format.html { redirect_to @stage_population, notice: 'Stage population was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage_population.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stage_populations/1
  # DELETE /stage_populations/1.json
  def destroy
    @stage_population = StagePopulation.find(params[:id])
    @stage_population.destroy

    respond_to do |format|
      format.html { redirect_to stage_populations_url }
      format.json { head :no_content }
    end
  end
end
