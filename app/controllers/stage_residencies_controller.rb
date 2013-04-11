class StageResidenciesController < ApplicationController
  # GET /stage_residencies
  # GET /stage_residencies.json
  def index
    @stage_residencies = StageResidency.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stage_residencies }
    end
  end

  # GET /stage_residencies/1
  # GET /stage_residencies/1.json
  def show
    @stage_residency = StageResidency.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage_residency }
    end
  end

  # GET /stage_residencies/new
  # GET /stage_residencies/new.json
  def new
    @stage_residency = StageResidency.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage_residency }
    end
  end

  # GET /stage_residencies/1/edit
  def edit
    @stage_residency = StageResidency.find(params[:id])
  end

  # POST /stage_residencies
  # POST /stage_residencies.json
  def create
    @stage_residency = StageResidency.new(params[:stage_residency])

    respond_to do |format|
      if @stage_residency.save
        format.html { redirect_to @stage_residency, notice: 'Stage residency was successfully created.' }
        format.json { render json: @stage_residency, status: :created, location: @stage_residency }
      else
        format.html { render action: "new" }
        format.json { render json: @stage_residency.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stage_residencies/1
  # PUT /stage_residencies/1.json
  def update
    @stage_residency = StageResidency.find(params[:id])

    respond_to do |format|
      if @stage_residency.update_attributes(params[:stage_residency])
        format.html { redirect_to @stage_residency, notice: 'Stage residency was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage_residency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stage_residencies/1
  # DELETE /stage_residencies/1.json
  def destroy
    @stage_residency = StageResidency.find(params[:id])
    @stage_residency.destroy

    respond_to do |format|
      format.html { redirect_to stage_residencies_url }
      format.json { head :no_content }
    end
  end
end
