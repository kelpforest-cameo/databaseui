class NodeMaxAgesController < ApplicationController
  # GET /node_max_ages
  # GET /node_max_ages.json
  def index
    @node_max_ages = NodeMaxAge.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @node_max_ages }
    end
  end

  # GET /node_max_ages/1
  # GET /node_max_ages/1.json
  def show
    @node_max_age = NodeMaxAge.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @node_max_age }
    end
  end

  # GET /node_max_ages/new
  # GET /node_max_ages/new.json
  def new
    @node_max_age = NodeMaxAge.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @node_max_age }
    end
  end

  # GET /node_max_ages/1/edit
  def edit
    @node_max_age = NodeMaxAge.find(params[:id])
  end

  # POST /node_max_ages
  # POST /node_max_ages.json
  def create
    @node_max_age = NodeMaxAge.new(params[:node_max_age])

    respond_to do |format|
      if @node_max_age.save
        format.html { redirect_to @node_max_age, notice: 'Node max age was successfully created.' }
        format.json { render json: @node_max_age, status: :created, location: @node_max_age }
      else
        format.html { render action: "new" }
        format.json { render json: @node_max_age.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /node_max_ages/1
  # PUT /node_max_ages/1.json
  def update
    @node_max_age = NodeMaxAge.find(params[:id])

    respond_to do |format|
      if @node_max_age.update_attributes(params[:node_max_age])
        format.html { redirect_to @node_max_age, notice: 'Node max age was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @node_max_age.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /node_max_ages/1
  # DELETE /node_max_ages/1.json
  def destroy
    @node_max_age = NodeMaxAge.find(params[:id])
    @node_max_age.destroy

    respond_to do |format|
      format.html { redirect_to node_max_ages_url }
      format.json { head :no_content }
    end
  end
end
