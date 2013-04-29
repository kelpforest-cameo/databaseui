class StagesController < ApplicationController
  # GET /stages
  # GET /stages.json
  def index
    @stages = Stage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stages }
    end
  end

  # GET /stages/1
  # GET /stages/1.json
  def show
    @stage = Stage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage }
    end
  end

  # GET /stages/new
  # GET /stages/new.json
  def new
    @stage = Stage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage }
    end
  end

  # GET /stages/1/edit
  def edit
    @stage = Stage.find(params[:id])
  end

  # POST /stages
  # POST /stages.json
  def create
    @stage = Stage.new(params[:stage])

    respond_to do |format|
      if @stage.save
        format.html { redirect_to @stage, notice: 'Stage was successfully created.' }
        format.json { render json: @stage, status: :created, location: @stage }
      else
        format.html { render action: "new" }
        format.json { render json: @stage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stages/1
  # PUT /stages/1.json
  def update
    @stage = Stage.find(params[:id])

    respond_to do |format|
      if @stage.update_attributes(params[:stage])
        format.html { redirect_to @stage, notice: 'Stage was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stages/1
  # DELETE /stages/1.json
  def destroy
    @stage = Stage.find(params[:id])
    @stage.destroy

    respond_to do |format|
      format.html { redirect_to stages_url }
      format.json { head :no_content }
    end
  end
end
