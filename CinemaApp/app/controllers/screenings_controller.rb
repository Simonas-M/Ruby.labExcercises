require 'time'
class ScreeningsController < ApplicationController
  before_action :set_screening, only: [:show, :destroy]

  # GET /screenings
  # GET /screenings.json
  def index
    @screenings = Screening.all
  end

  # GET /screenings/1
  # GET /screenings/1.json
  def show
  end

  # POST /screenings
  # POST /screenings.json
  def create
    @screening = Screening.new(
      time: Time.parse(params[:time] + 'Z'),
      movie: Movie.find(params[:movie]),
      screen: Screen.find(params[:screen])
    )

    respond_to do |format|
      if @screening.save
        format.html { redirect_to @screening, notice: 'Screening was successfully created.' }
        format.json { render :show, status: :created, location: @screening }
      else
        format.html { render :new }
        format.json { render json: @screening.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /screenings/1
  # DELETE /screenings/1.json
  def destroy
    @screening.destroy
    respond_to do |format|
      format.html { redirect_to screenings_url, notice: 'Screening was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_screening
      @screening = Screening.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def screening_params
      params.fetch(:screening, {})
    end
end
