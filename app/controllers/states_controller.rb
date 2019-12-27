class StatesController < ApplicationController
  before_action :set_state, only: [:show, :edit, :update, :destroy]

  # GET /states
  # GET /states.json
  def index
    @states = State.all
  end

  # GET /states/1
  # GET /states/1.json
  def show
  end

  # GET /states/new
  def new
    @state = State.new
  end

  # GET /states/1/edit
  def edit
  end

  # POST /states
  # POST /states.json
  def create
    @state = State.new(snow_data_params)

    respond_to do |format|
      if @snow_data.save
        format.html { redirect_to @snow_data, notice: 'Snow Data was successfully created.' }
        format.json { render :show, status: :created, location: @snow_data }
      else
        format.html { render :new }
        format.json { render json: @snow_data.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /states/1
  # PATCH/PUT /states/1.json
  def update
    respond_to do |format|
      if @snow_data.update(snow_data_params)
        format.html { redirect_to @snow_data, notice: 'State was successfully updated.' }
        format.json { render :show, status: :ok, location: @snow_data }
      else
        format.html { render :edit }
        format.json { render json: @snow_data.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /states/1
  # DELETE /states/1.json
  def destroy
    @snow_data.destroy
    respond_to do |format|
      format.html { redirect_to snow_data_url, notice: 'State was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_state
      @snow_data = SnowData.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def state_params
      params.require(:state).permit(:state_name, :state_url)
    end
end
