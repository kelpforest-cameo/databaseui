class StageConsumerStrategiesController < ApplicationController
  # GET /stage_consumer_strategies
  # GET /stage_consumer_strategies.json
  def index
    @stage_consumer_strategies = StageConsumerStrategy.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stage_consumer_strategies }
    end
  end

  # GET /stage_consumer_strategies/1
  # GET /stage_consumer_strategies/1.json
  def show
    @stage_consumer_strategy = StageConsumerStrategy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage_consumer_strategy }
    end
  end

  # GET /stage_consumer_strategies/new
  # GET /stage_consumer_strategies/new.json
  def new
    @stage_consumer_strategy = StageConsumerStrategy.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage_consumer_strategy }
    end
  end

  # GET /stage_consumer_strategies/1/edit
  def edit
    @stage_consumer_strategy = StageConsumerStrategy.find(params[:id])
  end

  # POST /stage_consumer_strategies
  # POST /stage_consumer_strategies.json
  def create
    @stage_consumer_strategy = StageConsumerStrategy.new(params[:stage_consumer_strategy])

    respond_to do |format|
      if @stage_consumer_strategy.save
        format.html { redirect_to @stage_consumer_strategy, notice: 'Stage consumer strategy was successfully created.' }
        format.json { render json: @stage_consumer_strategy, status: :created, location: @stage_consumer_strategy }
      else
        format.html { render action: "new" }
        format.json { render json: @stage_consumer_strategy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stage_consumer_strategies/1
  # PUT /stage_consumer_strategies/1.json
  def update
    @stage_consumer_strategy = StageConsumerStrategy.find(params[:id])

    respond_to do |format|
      if @stage_consumer_strategy.update_attributes(params[:stage_consumer_strategy])
        format.html { redirect_to @stage_consumer_strategy, notice: 'Stage consumer strategy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage_consumer_strategy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stage_consumer_strategies/1
  # DELETE /stage_consumer_strategies/1.json
  def destroy
    @stage_consumer_strategy = StageConsumerStrategy.find(params[:id])
    @stage_consumer_strategy.destroy

    respond_to do |format|
      format.html { redirect_to stage_consumer_strategies_url }
      format.json { head :no_content }
    end
  end
end
