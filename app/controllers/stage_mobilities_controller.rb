class StageMobilitiesController < ApplicationController
  # GET /stage_mobilities
  # GET /stage_mobilities.json
  def index
    @stage_mobilities = StageMobility.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stage_mobilities }
    end
  end

  # GET /stage_mobilities/1
  # GET /stage_mobilities/1.json
  def show
    @stage_mobility = StageMobility.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage_mobility }
    end
  end

  # GET /stage_mobilities/new
  # GET /stage_mobilities/new.json
  def new
    @stage_mobility = StageMobility.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage_mobility }
    end
  end

  # GET /stage_mobilities/1/edit
  def edit
    @stage_mobility = StageMobility.find(params[:id])
  end

  # POST /stage_mobilities
  # POST /stage_mobilities.json
  def create
    @stage_mobility = StageMobility.new(params[:stage_mobility])

    respond_to do |format|
      if @stage_mobility.save
        format.html { redirect_to @stage_mobility, notice: 'Stage mobility was successfully created.' }
        format.json { render json: @stage_mobility, status: :created, location: @stage_mobility }
      else
        format.html { render action: "new" }
        format.json { render json: @stage_mobility.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stage_mobilities/1
  # PUT /stage_mobilities/1.json
  def update
    @stage_mobility = StageMobility.find(params[:id])

    respond_to do |format|
      if @stage_mobility.update_attributes(params[:stage_mobility])
        format.html { redirect_to @stage_mobility, notice: 'Stage mobility was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage_mobility.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stage_mobilities/1
  # DELETE /stage_mobilities/1.json
  def destroy
    @stage_mobility = StageMobility.find(params[:id])
    @stage_mobility.destroy

    respond_to do |format|
      format.html { redirect_to stage_mobilities_url }
      format.json { head :no_content }
    end
  end
end
