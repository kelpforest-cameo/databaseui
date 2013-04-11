class StageMaxDepthsController < ApplicationController
  # GET /stage_max_depths
  # GET /stage_max_depths.json
  def index
    @stage_max_depths = StageMaxDepth.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stage_max_depths }
    end
  end

  # GET /stage_max_depths/1
  # GET /stage_max_depths/1.json
  def show
    @stage_max_depth = StageMaxDepth.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage_max_depth }
    end
  end

  # GET /stage_max_depths/new
  # GET /stage_max_depths/new.json
  def new
    @stage_max_depth = StageMaxDepth.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage_max_depth }
    end
  end

  # GET /stage_max_depths/1/edit
  def edit
    @stage_max_depth = StageMaxDepth.find(params[:id])
  end

  # POST /stage_max_depths
  # POST /stage_max_depths.json
  def create
    @stage_max_depth = StageMaxDepth.new(params[:stage_max_depth])

    respond_to do |format|
      if @stage_max_depth.save
        format.html { redirect_to @stage_max_depth, notice: 'Stage max depth was successfully created.' }
        format.json { render json: @stage_max_depth, status: :created, location: @stage_max_depth }
      else
        format.html { render action: "new" }
        format.json { render json: @stage_max_depth.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stage_max_depths/1
  # PUT /stage_max_depths/1.json
  def update
    @stage_max_depth = StageMaxDepth.find(params[:id])

    respond_to do |format|
      if @stage_max_depth.update_attributes(params[:stage_max_depth])
        format.html { redirect_to @stage_max_depth, notice: 'Stage max depth was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage_max_depth.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stage_max_depths/1
  # DELETE /stage_max_depths/1.json
  def destroy
    @stage_max_depth = StageMaxDepth.find(params[:id])
    @stage_max_depth.destroy

    respond_to do |format|
      format.html { redirect_to stage_max_depths_url }
      format.json { head :no_content }
    end
  end
end
