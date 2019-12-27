class SnowDataController < ApplicationController
  before_action :set_snow_datum, only: [:show, :edit, :update, :destroy]

  # GET /snow_data
  # GET /snow_data.json
  def index
    @snow_data = SnowDatum.all
  end

  # GET /snow_data/1
  # GET /snow_data/1.json
  def show
    @state = State.where(:id => params[:id]).includes(:resorts => [:snow_data]).first!
  end

  # GET /snow_data/new
  def new
    @snow_datum = SnowDatum.new
  end

  # GET /snow_data/1/edit
  def edit
  end

  # POST /snow_data
  # POST /snow_data.json
  def create
    @snow_datum = SnowDatum.new(snow_datum_params)

    respond_to do |format|
      if @snow_datum.save
        format.html { redirect_to @snow_datum, notice: 'Snow datum was successfully created.' }
        format.json { render :show, status: :created, location: @snow_datum }
      else
        format.html { render :new }
        format.json { render json: @snow_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /snow_data/1
  # PATCH/PUT /snow_data/1.json
  def update
    respond_to do |format|
      if @snow_datum.update(snow_datum_params)
        format.html { redirect_to @snow_datum, notice: 'Snow datum was successfully updated.' }
        format.json { render :show, status: :ok, location: @snow_datum }
      else
        format.html { render :edit }
        format.json { render json: @snow_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /snow_data/1
  # DELETE /snow_data/1.json
  def destroy
    @snow_datum.destroy
    respond_to do |format|
      format.html { redirect_to snow_data_url, notice: 'Snow datum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_snow_datum
      @snow_datum = SnowDatum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def snow_datum_params
      params.require(:snow_datum).permit(:recent_time, :recent_snowfall, :next_snowfall, :next5_snowfall, :resort_id)
    end
end
