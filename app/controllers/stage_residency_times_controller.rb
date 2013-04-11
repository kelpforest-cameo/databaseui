class StageResidencyTimesController < ApplicationController
  # GET /stage_residency_times
  # GET /stage_residency_times.json
  def index
    @stage_residency_times = StageResidencyTime.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stage_residency_times }
    end
  end

  # GET /stage_residency_times/1
  # GET /stage_residency_times/1.json
  def show
    @stage_residency_time = StageResidencyTime.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage_residency_time }
    end
  end

  # GET /stage_residency_times/new
  # GET /stage_residency_times/new.json
  def new
    @stage_residency_time = StageResidencyTime.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage_residency_time }
    end
  end

  # GET /stage_residency_times/1/edit
  def edit
    @stage_residency_time = StageResidencyTime.find(params[:id])
  end

  # POST /stage_residency_times
  # POST /stage_residency_times.json
  def create
    @stage_residency_time = StageResidencyTime.new(params[:stage_residency_time])

    respond_to do |format|
      if @stage_residency_time.save
        format.html { redirect_to @stage_residency_time, notice: 'Stage residency time was successfully created.' }
        format.json { render json: @stage_residency_time, status: :created, location: @stage_residency_time }
      else
        format.html { render action: "new" }
        format.json { render json: @stage_residency_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stage_residency_times/1
  # PUT /stage_residency_times/1.json
  def update
    @stage_residency_time = StageResidencyTime.find(params[:id])

    respond_to do |format|
      if @stage_residency_time.update_attributes(params[:stage_residency_time])
        format.html { redirect_to @stage_residency_time, notice: 'Stage residency time was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage_residency_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stage_residency_times/1
  # DELETE /stage_residency_times/1.json
  def destroy
    @stage_residency_time = StageResidencyTime.find(params[:id])
    @stage_residency_time.destroy

    respond_to do |format|
      format.html { redirect_to stage_residency_times_url }
      format.json { head :no_content }
    end
  end
end
