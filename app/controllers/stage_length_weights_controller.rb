class StageLengthWeightsController < ApplicationController
  # GET /stage_length_weights
  # GET /stage_length_weights.json
  def index
    @stage_length_weights = StageLengthWeight.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stage_length_weights }
    end
  end

  # GET /stage_length_weights/1
  # GET /stage_length_weights/1.json
  def show
    @stage_length_weight = StageLengthWeight.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage_length_weight }
    end
  end

  # GET /stage_length_weights/new
  # GET /stage_length_weights/new.json
  def new
    @stage_length_weight = StageLengthWeight.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage_length_weight }
    end
  end

  # GET /stage_length_weights/1/edit
  def edit
    @stage_length_weight = StageLengthWeight.find(params[:id])
  end

  # POST /stage_length_weights
  # POST /stage_length_weights.json
  def create
    @stage_length_weight = StageLengthWeight.new(params[:stage_length_weight])

    respond_to do |format|
      if @stage_length_weight.save
        format.html { redirect_to @stage_length_weight, notice: 'Stage length weight was successfully created.' }
        format.json { render json: @stage_length_weight, status: :created, location: @stage_length_weight }
      else
        format.html { render action: "new" }
        format.json { render json: @stage_length_weight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stage_length_weights/1
  # PUT /stage_length_weights/1.json
  def update
    @stage_length_weight = StageLengthWeight.find(params[:id])

    respond_to do |format|
      if @stage_length_weight.update_attributes(params[:stage_length_weight])
        format.html { redirect_to @stage_length_weight, notice: 'Stage length weight was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage_length_weight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stage_length_weights/1
  # DELETE /stage_length_weights/1.json
  def destroy
    @stage_length_weight = StageLengthWeight.find(params[:id])
    @stage_length_weight.destroy

    respond_to do |format|
      format.html { redirect_to stage_length_weights_url }
      format.json { head :no_content }
    end
  end
end
