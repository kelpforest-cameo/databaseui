class StageUnassimilatedConsumRatiosController < ApplicationController
  # GET /stage_unassimilated_consum_ratios
  # GET /stage_unassimilated_consum_ratios.json
  def index
    @stage_unassimilated_consum_ratios = StageUnassimilatedConsumRatio.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stage_unassimilated_consum_ratios }
    end
  end

  # GET /stage_unassimilated_consum_ratios/1
  # GET /stage_unassimilated_consum_ratios/1.json
  def show
    @stage_unassimilated_consum_ratio = StageUnassimilatedConsumRatio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stage_unassimilated_consum_ratio }
    end
  end

  # GET /stage_unassimilated_consum_ratios/new
  # GET /stage_unassimilated_consum_ratios/new.json
  def new
    @stage_unassimilated_consum_ratio = StageUnassimilatedConsumRatio.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stage_unassimilated_consum_ratio }
    end
  end

  # GET /stage_unassimilated_consum_ratios/1/edit
  def edit
    @stage_unassimilated_consum_ratio = StageUnassimilatedConsumRatio.find(params[:id])
  end

  # POST /stage_unassimilated_consum_ratios
  # POST /stage_unassimilated_consum_ratios.json
  def create
    @stage_unassimilated_consum_ratio = StageUnassimilatedConsumRatio.new(params[:stage_unassimilated_consum_ratio])

    respond_to do |format|
      if @stage_unassimilated_consum_ratio.save
        format.html { redirect_to @stage_unassimilated_consum_ratio, notice: 'Stage unassimilated consum ratio was successfully created.' }
        format.json { render json: @stage_unassimilated_consum_ratio, status: :created, location: @stage_unassimilated_consum_ratio }
      else
        format.html { render action: "new" }
        format.json { render json: @stage_unassimilated_consum_ratio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stage_unassimilated_consum_ratios/1
  # PUT /stage_unassimilated_consum_ratios/1.json
  def update
    @stage_unassimilated_consum_ratio = StageUnassimilatedConsumRatio.find(params[:id])

    respond_to do |format|
      if @stage_unassimilated_consum_ratio.update_attributes(params[:stage_unassimilated_consum_ratio])
        format.html { redirect_to @stage_unassimilated_consum_ratio, notice: 'Stage unassimilated consum ratio was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stage_unassimilated_consum_ratio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stage_unassimilated_consum_ratios/1
  # DELETE /stage_unassimilated_consum_ratios/1.json
  def destroy
    @stage_unassimilated_consum_ratio = StageUnassimilatedConsumRatio.find(params[:id])
    @stage_unassimilated_consum_ratio.destroy

    respond_to do |format|
      format.html { redirect_to stage_unassimilated_consum_ratios_url }
      format.json { head :no_content }
    end
  end
end
