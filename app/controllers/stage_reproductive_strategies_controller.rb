class StageReproductiveStrategiesController < ApplicationController
  # GET /stage_reproductive_strategies
  # GET /stage_reproductive_strategies.json
  def index
    @stage_reproductive_strategies = StageReproductiveStrategy.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stage_reproductive_strategies }
    end
  end

  # GET /stage_reproductive_strategies/1
  # GET /stage_reproductive_strategies/1.json
  def show
    @stage_reproductive_strategy = StageReproductiveStrategy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage_reproductive_strategy }
    end
  end

  # GET /stage_reproductive_strategies/new
  # GET /stage_reproductive_strategies/new.json
  def new
    @stage_reproductive_strategy = StageReproductiveStrategy.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage_reproductive_strategy }
    end
  end

  # GET /stage_reproductive_strategies/1/edit
  def edit
    @stage_reproductive_strategy = StageReproductiveStrategy.find(params[:id])
  end

  # POST /stage_reproductive_strategies
  # POST /stage_reproductive_strategies.json
  def create
    @stage_reproductive_strategy = StageReproductiveStrategy.new(params[:stage_reproductive_strategy])

    respond_to do |format|
      if @stage_reproductive_strategy.save
        format.html { redirect_to @stage_reproductive_strategy, notice: 'Stage reproductive strategy was successfully created.' }
        format.json { render json: @stage_reproductive_strategy, status: :created, location: @stage_reproductive_strategy }
      else
        format.html { render action: "new" }
        format.json { render json: @stage_reproductive_strategy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stage_reproductive_strategies/1
  # PUT /stage_reproductive_strategies/1.json
  def update
    @stage_reproductive_strategy = StageReproductiveStrategy.find(params[:id])

    respond_to do |format|
      if @stage_reproductive_strategy.update_attributes(params[:stage_reproductive_strategy])
        format.html { redirect_to @stage_reproductive_strategy, notice: 'Stage reproductive strategy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage_reproductive_strategy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stage_reproductive_strategies/1
  # DELETE /stage_reproductive_strategies/1.json
  def destroy
    @stage_reproductive_strategy = StageReproductiveStrategy.find(params[:id])
    @stage_reproductive_strategy.destroy

    respond_to do |format|
      format.html { redirect_to stage_reproductive_strategies_url }
      format.json { head :no_content }
    end
  end
end
