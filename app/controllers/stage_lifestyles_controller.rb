class StageLifestylesController < ApplicationController
  # GET /stage_lifestyles
  # GET /stage_lifestyles.json
  def index
    @stage_lifestyles = StageLifestyle.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stage_lifestyles }
    end
  end

  # GET /stage_lifestyles/1
  # GET /stage_lifestyles/1.json
  def show
    @stage_lifestyle = StageLifestyle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage_lifestyle }
    end
  end

  # GET /stage_lifestyles/new
  # GET /stage_lifestyles/new.json
  def new
    @stage_lifestyle = StageLifestyle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage_lifestyle }
    end
  end

  # GET /stage_lifestyles/1/edit
  def edit
    @stage_lifestyle = StageLifestyle.find(params[:id])
  end

  # POST /stage_lifestyles
  # POST /stage_lifestyles.json
  def create
    @stage_lifestyle = StageLifestyle.new(params[:stage_lifestyle])

    respond_to do |format|
      if @stage_lifestyle.save
        format.html { redirect_to @stage_lifestyle, notice: 'Stage lifestyle was successfully created.' }
        format.json { render json: @stage_lifestyle, status: :created, location: @stage_lifestyle }
      else
        format.html { render action: "new" }
        format.json { render json: @stage_lifestyle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stage_lifestyles/1
  # PUT /stage_lifestyles/1.json
  def update
    @stage_lifestyle = StageLifestyle.find(params[:id])

    respond_to do |format|
      if @stage_lifestyle.update_attributes(params[:stage_lifestyle])
        format.html { redirect_to @stage_lifestyle, notice: 'Stage lifestyle was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage_lifestyle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stage_lifestyles/1
  # DELETE /stage_lifestyles/1.json
  def destroy
    @stage_lifestyle = StageLifestyle.find(params[:id])
    @stage_lifestyle.destroy

    respond_to do |format|
      format.html { redirect_to stage_lifestyles_url }
      format.json { head :no_content }
    end
  end
end
