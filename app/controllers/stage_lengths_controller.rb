class StageLengthsController < ApplicationController
  # GET /stage_lengths
  # GET /stage_lengths.json
  def index
    @stage_lengths = StageLength.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stage_lengths }
    end
  end

  # GET /stage_lengths/1
  # GET /stage_lengths/1.json
  def show
    @stage_length = StageLength.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage_length }
    end
  end

  # GET /stage_lengths/new
  # GET /stage_lengths/new.json
  def new
    @stage_length = StageLength.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage_length }
    end
  end

  # GET /stage_lengths/1/edit
  def edit
    @stage_length = StageLength.find(params[:id])
  end

  # POST /stage_lengths
  # POST /stage_lengths.json
  def create
    @stage_length = StageLength.new(params[:stage_length])

    respond_to do |format|
      if @stage_length.save
        format.html { redirect_to @stage_length, notice: 'Stage length was successfully created.' }
        format.json { render json: @stage_length, status: :created, location: @stage_length }
      else
        format.html { render action: "new" }
        format.json { render json: @stage_length.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stage_lengths/1
  # PUT /stage_lengths/1.json
  def update
    @stage_length = StageLength.find(params[:id])

    respond_to do |format|
      if @stage_length.update_attributes(params[:stage_length])
        format.html { redirect_to @stage_length, notice: 'Stage length was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage_length.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stage_lengths/1
  # DELETE /stage_lengths/1.json
  def destroy
    @stage_length = StageLength.find(params[:id])
    @stage_length.destroy

    respond_to do |format|
      format.html { redirect_to stage_lengths_url }
      format.json { head :no_content }
    end
  end
end
