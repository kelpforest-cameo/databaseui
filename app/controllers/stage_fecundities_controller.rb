class StageFecunditiesController < ApplicationController
  # GET /stage_fecundities
  # GET /stage_fecundities.json
  def index
    @stage_fecundities = StageFecundity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stage_fecundities }
    end
  end

  # GET /stage_fecundities/1
  # GET /stage_fecundities/1.json
  def show
    @stage_fecundity = StageFecundity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage_fecundity }
    end
  end

  # GET /stage_fecundities/new
  # GET /stage_fecundities/new.json
  def new
    @stage_fecundity = StageFecundity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage_fecundity }
    end
  end

  # GET /stage_fecundities/1/edit
  def edit
    @stage_fecundity = StageFecundity.find(params[:id])
  end

  # POST /stage_fecundities
  # POST /stage_fecundities.json
  def create
    @stage_fecundity = StageFecundity.new(params[:stage_fecundity])

    respond_to do |format|
      if @stage_fecundity.save
        format.html { redirect_to @stage_fecundity, notice: 'Stage fecundity was successfully created.' }
        format.json { render json: @stage_fecundity, status: :created, location: @stage_fecundity }
      else
        format.html { render action: "new" }
        format.json { render json: @stage_fecundity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stage_fecundities/1
  # PUT /stage_fecundities/1.json
  def update
    @stage_fecundity = StageFecundity.find(params[:id])

    respond_to do |format|
      if @stage_fecundity.update_attributes(params[:stage_fecundity])
        format.html { redirect_to @stage_fecundity, notice: 'Stage fecundity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage_fecundity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stage_fecundities/1
  # DELETE /stage_fecundities/1.json
  def destroy
    @stage_fecundity = StageFecundity.find(params[:id])
    @stage_fecundity.destroy

    respond_to do |format|
      format.html { redirect_to stage_fecundities_url }
      format.json { head :no_content }
    end
  end
end
