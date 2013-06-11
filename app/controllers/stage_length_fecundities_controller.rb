class StageLengthFecunditiesController < ApplicationController
  # GET /stage_length_fecundities
  # GET /stage_length_fecundities.json
  def index
    @stage_length_fecundities = StageLengthFecundity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stage_length_fecundities }
    end
  end

  # GET /stage_length_fecundities/1
  # GET /stage_length_fecundities/1.json
  def show
    @stage_length_fecundity = StageLengthFecundity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage_length_fecundity }
    end
  end

  # GET /stage_length_fecundities/new
  # GET /stage_length_fecundities/new.json
  def new
    @stage_length_fecundity = StageLengthFecundity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage_length_fecundity }
    end
  end

  # GET /stage_length_fecundities/1/edit
  def edit
    @stage_length_fecundity = StageLengthFecundity.find(params[:id])
  end

  # POST /stage_length_fecundities
  # POST /stage_length_fecundities.json
  def create
    @stage_length_fecundity = StageLengthFecundity.new(params[:stage_length_fecundity])

    respond_to do |format|
      if @stage_length_fecundity.save
        format.html { redirect_to @stage_length_fecundity, notice: 'Stage length fecundity was successfully created.' }
        format.json { render json: @stage_length_fecundity, status: :created, location: @stage_length_fecundity }
      else
        format.html { render action: "new" }
        format.json { render json: @stage_length_fecundity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stage_length_fecundities/1
  # PUT /stage_length_fecundities/1.json
  def update
    @stage_length_fecundity = StageLengthFecundity.find(params[:id])

    respond_to do |format|
      if @stage_length_fecundity.update_attributes(params[:stage_length_fecundity])
        format.html { redirect_to @stage_length_fecundity, notice: 'Stage length fecundity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage_length_fecundity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stage_length_fecundities/1
  # DELETE /stage_length_fecundities/1.json
  def destroy
    @stage_length_fecundity = StageLengthFecundity.find(params[:id])
    @stage_length_fecundity.destroy

    respond_to do |format|
      format.html { redirect_to stage_length_fecundities_url }
      format.json { head :no_content }
    end
  end
end
