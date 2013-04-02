class StageMassesController < ApplicationController
  # GET /stage_masses
  # GET /stage_masses.json
  def index
    @stage_masses = StageMass.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stage_masses }
    end
  end

  # GET /stage_masses/1
  # GET /stage_masses/1.json
  def show
    @stage_mass = StageMass.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage_mass }
    end
  end

  # GET /stage_masses/new
  # GET /stage_masses/new.json
  def new
    @stage_mass = StageMass.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage_mass }
    end
  end

  # GET /stage_masses/1/edit
  def edit
    @stage_mass = StageMass.find(params[:id])
  end

  # POST /stage_masses
  # POST /stage_masses.json
  def create
    @stage_mass = StageMass.new(params[:stage_mass])

    respond_to do |format|
      if @stage_mass.save
        format.html { redirect_to @stage_mass, notice: 'Stage mass was successfully created.' }
        format.json { render json: @stage_mass, status: :created, location: @stage_mass }
      else
        format.html { render action: "new" }
        format.json { render json: @stage_mass.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stage_masses/1
  # PUT /stage_masses/1.json
  def update
    @stage_mass = StageMass.find(params[:id])

    respond_to do |format|
      if @stage_mass.update_attributes(params[:stage_mass])
        format.html { redirect_to @stage_mass, notice: 'Stage mass was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage_mass.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stage_masses/1
  # DELETE /stage_masses/1.json
  def destroy
    @stage_mass = StageMass.find(params[:id])
    @stage_mass.destroy

    respond_to do |format|
      format.html { redirect_to stage_masses_url }
      format.json { head :no_content }
    end
  end
end
