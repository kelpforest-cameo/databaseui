class DataentriesController < ApplicationController
  # GET /dataentries
  # GET /dataentries.json
  def index
    @dataentries = Dataentry.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dataentries }
    end
  end

  # GET /dataentries/1
  # GET /dataentries/1.json
  def show
    @dataentry = Dataentry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dataentry }
    end
  end

  # GET /dataentries/new
  # GET /dataentries/new.json
  def new
    @dataentry = Dataentry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dataentry }
    end
  end

  # GET /dataentries/1/edit
  def edit
    @dataentry = Dataentry.find(params[:id])
  end

  # POST /dataentries
  # POST /dataentries.json
  def create
    @dataentry = Dataentry.new(params[:dataentry])

    respond_to do |format|
      if @dataentry.save
        format.html { redirect_to @dataentry, notice: 'Dataentry was successfully created.' }
        format.json { render json: @dataentry, status: :created, location: @dataentry }
      else
        format.html { render action: "new" }
        format.json { render json: @dataentry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dataentries/1
  # PUT /dataentries/1.json
  def update
    @dataentry = Dataentry.find(params[:id])

    respond_to do |format|
      if @dataentry.update_attributes(params[:dataentry])
        format.html { redirect_to @dataentry, notice: 'Dataentry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dataentry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dataentries/1
  # DELETE /dataentries/1.json
  def destroy
    @dataentry = Dataentry.find(params[:id])
    @dataentry.destroy

    respond_to do |format|
      format.html { redirect_to dataentries_url }
      format.json { head :no_content }
    end
  end
end
