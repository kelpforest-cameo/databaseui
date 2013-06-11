class StageHabitatDescriptorsController < ApplicationController
  # GET /stage_habitat_descriptors
  # GET /stage_habitat_descriptors.json
  def index
    @stage_habitat_descriptors = StageHabitatDescriptor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stage_habitat_descriptors }
    end
  end

  # GET /stage_habitat_descriptors/1
  # GET /stage_habitat_descriptors/1.json
  def show
    @stage_habitat_descriptor = StageHabitatDescriptor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage_habitat_descriptor }
    end
  end

  # GET /stage_habitat_descriptors/new
  # GET /stage_habitat_descriptors/new.json
  def new
    @stage_habitat_descriptor = StageHabitatDescriptor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage_habitat_descriptor }
    end
  end

  # GET /stage_habitat_descriptors/1/edit
  def edit
    @stage_habitat_descriptor = StageHabitatDescriptor.find(params[:id])
  end

  # POST /stage_habitat_descriptors
  # POST /stage_habitat_descriptors.json
  def create
    @stage_habitat_descriptor = StageHabitatDescriptor.new(params[:stage_habitat_descriptor])

    respond_to do |format|
      if @stage_habitat_descriptor.save
        format.html { redirect_to @stage_habitat_descriptor, notice: 'Stage habitat descriptor was successfully created.' }
        format.json { render json: @stage_habitat_descriptor, status: :created, location: @stage_habitat_descriptor }
      else
        format.html { render action: "new" }
        format.json { render json: @stage_habitat_descriptor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stage_habitat_descriptors/1
  # PUT /stage_habitat_descriptors/1.json
  def update
    @stage_habitat_descriptor = StageHabitatDescriptor.find(params[:id])

    respond_to do |format|
      if @stage_habitat_descriptor.update_attributes(params[:stage_habitat_descriptor])
        format.html { redirect_to @stage_habitat_descriptor, notice: 'Stage habitat descriptor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage_habitat_descriptor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stage_habitat_descriptors/1
  # DELETE /stage_habitat_descriptors/1.json
  def destroy
    @stage_habitat_descriptor = StageHabitatDescriptor.find(params[:id])
    @stage_habitat_descriptor.destroy

    respond_to do |format|
      format.html { redirect_to stage_habitat_descriptors_url }
      format.json { head :no_content }
    end
  end
end
