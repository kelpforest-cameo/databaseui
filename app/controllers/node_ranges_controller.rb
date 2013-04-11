class NodeRangesController < ApplicationController
  # GET /node_ranges
  # GET /node_ranges.json
  def index
    @node_ranges = NodeRange.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @node_ranges }
    end
  end

  # GET /node_ranges/1
  # GET /node_ranges/1.json
  def show
    @node_range = NodeRange.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @node_range }
    end
  end

  # GET /node_ranges/new
  # GET /node_ranges/new.json
  def new
    @node_range = NodeRange.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @node_range }
    end
  end

  # GET /node_ranges/1/edit
  def edit
    @node_range = NodeRange.find(params[:id])
  end

  # POST /node_ranges
  # POST /node_ranges.json
  def create
    @node_range = NodeRange.new(params[:node_range])

    respond_to do |format|
      if @node_range.save
        format.html { redirect_to @node_range, notice: 'Node range was successfully created.' }
        format.json { render json: @node_range, status: :created, location: @node_range }
      else
        format.html { render action: "new" }
        format.json { render json: @node_range.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /node_ranges/1
  # PUT /node_ranges/1.json
  def update
    @node_range = NodeRange.find(params[:id])

    respond_to do |format|
      if @node_range.update_attributes(params[:node_range])
        format.html { redirect_to @node_range, notice: 'Node range was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @node_range.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /node_ranges/1
  # DELETE /node_ranges/1.json
  def destroy
    @node_range = NodeRange.find(params[:id])
    @node_range.destroy

    respond_to do |format|
      format.html { redirect_to node_ranges_url }
      format.json { head :no_content }
    end
  end
end
