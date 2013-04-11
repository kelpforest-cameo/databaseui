class StageDrymassesController < ApplicationController
  # GET /stage_drymasses
  # GET /stage_drymasses.json
  def index
    @stage_drymasses = StageDrymass.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stage_drymasses }
    end
  end

  # GET /stage_drymasses/1
  # GET /stage_drymasses/1.json
  def show
    @stage_drymass = StageDrymass.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage_drymass }
    end
  end

  # GET /stage_drymasses/new
  # GET /stage_drymasses/new.json
  def new
    @stage_drymass = StageDrymass.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage_drymass }
    end
  end

  # GET /stage_drymasses/1/edit
  def edit
    @stage_drymass = StageDrymass.find(params[:id])
  end

  # POST /stage_drymasses
  # POST /stage_drymasses.json
  def create
    @stage_drymass = StageDrymass.new(params[:stage_drymass])

    respond_to do |format|
      if @stage_drymass.save
        format.html { redirect_to @stage_drymass, notice: 'Stage drymass was successfully created.' }
        format.json { render json: @stage_drymass, status: :created, location: @stage_drymass }
      else
        format.html { render action: "new" }
        format.json { render json: @stage_drymass.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stage_drymasses/1
  # PUT /stage_drymasses/1.json
  def update
    @stage_drymass = StageDrymass.find(params[:id])

    respond_to do |format|
      if @stage_drymass.update_attributes(params[:stage_drymass])
        format.html { redirect_to @stage_drymass, notice: 'Stage drymass was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage_drymass.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stage_drymasses/1
  # DELETE /stage_drymasses/1.json
  def destroy
    @stage_drymass = StageDrymass.find(params[:id])
    @stage_drymass.destroy

    respond_to do |format|
      format.html { redirect_to stage_drymasses_url }
      format.json { head :no_content }
    end
  end
end
