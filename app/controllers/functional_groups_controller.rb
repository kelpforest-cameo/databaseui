class FunctionalGroupsController < ApplicationController
  # GET /functional_groups
  # GET /functional_groups.json
  def index
    @functional_groups = FunctionalGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @functional_groups }
    end
  end

  # GET /functional_groups/1
  # GET /functional_groups/1.json
  def show
    @functional_group = FunctionalGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @functional_group }
    end
  end

  # GET /functional_groups/new
  # GET /functional_groups/new.json
  def new
    @functional_group = FunctionalGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @functional_group }
    end
  end

  # GET /functional_groups/1/edit
  def edit
    @functional_group = FunctionalGroup.find(params[:id])
  end

  # POST /functional_groups
  # POST /functional_groups.json
  def create
    @functional_group = FunctionalGroup.new(params[:functional_group])

    respond_to do |format|
      if @functional_group.save
        format.html { redirect_to @functional_group, notice: 'Functional group was successfully created.' }
        format.json { render json: @functional_group, status: :created, location: @functional_group }
      else
        format.html { render action: "new" }
        format.json { render json: @functional_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /functional_groups/1
  # PUT /functional_groups/1.json
  def update
    @functional_group = FunctionalGroup.find(params[:id])

    respond_to do |format|
      if @functional_group.update_attributes(params[:functional_group])
        format.html { redirect_to @functional_group, notice: 'Functional group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @functional_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /functional_groups/1
  # DELETE /functional_groups/1.json
  def destroy
    @functional_group = FunctionalGroup.find(params[:id])
    @functional_group.destroy

    respond_to do |format|
      format.html { redirect_to functional_groups_url }
      format.json { head :no_content }
    end
  end
end
