class StageDurationsController < ApplicationController
  # GET /stage_durations
  # GET /stage_durations.json
  def index
    @stage_durations = StageDuration.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stage_durations }
    end
  end

  # GET /stage_durations/1
  # GET /stage_durations/1.json
  def show
    @stage_duration = StageDuration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage_duration }
    end
  end

  # GET /stage_durations/new
  # GET /stage_durations/new.json
  def new
    @stage_duration = StageDuration.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage_duration }
    end
  end

  # GET /stage_durations/1/edit
  def edit
    @stage_duration = StageDuration.find(params[:id])
  end

  # POST /stage_durations
  # POST /stage_durations.json
  def create
    @stage_duration = StageDuration.new(params[:stage_duration])

    respond_to do |format|
      if @stage_duration.save
        format.html { redirect_to @stage_duration, notice: 'Stage duration was successfully created.' }
        format.json { render json: @stage_duration, status: :created, location: @stage_duration }
      else
        format.html { render action: "new" }
        format.json { render json: @stage_duration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stage_durations/1
  # PUT /stage_durations/1.json
  def update
    @stage_duration = StageDuration.find(params[:id])

    respond_to do |format|
      if @stage_duration.update_attributes(params[:stage_duration])
        format.html { redirect_to @stage_duration, notice: 'Stage duration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage_duration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stage_durations/1
  # DELETE /stage_durations/1.json
  def destroy
    @stage_duration = StageDuration.find(params[:id])
    @stage_duration.destroy

    respond_to do |format|
      format.html { redirect_to stage_durations_url }
      format.json { head :no_content }
    end
  end
end
