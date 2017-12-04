# frozen_string_literal: true

require 'time'
class ScreeningsController < ApplicationController
  before_action :set_screening, only: %i[show destroy]

  # GET /screenings
  # GET /screenings.json
  def index
    @screenings = Screening.all
  end

  # GET /screenings/1
  # GET /screenings/1.json
  def show; end

  # POST /screenings
  # POST /screenings.json
  def create
    params = screening_params
    repertoire = Repertoire.first

    respond_to do |format|
      if repertoire.add_screening(new_screening: params)
        format.html do
          redirect_to Screening.find_by!(params),
                      notice: 'Screening was successfully created.'
        end
        format.json { render :show, status: :created, location: @screening }
      else
        format.html do
          redirect_to screenings_new_path,
                      notice: repertoire.errors[:screening][0][:message], status: 400
        end
        format.json do
          render json: @screening.errors,
                 status: 400
        end
      end
    end
  end

  # DELETE /screenings/1
  # DELETE /screenings/1.json
  def destroy
    @screening.destroy
    respond_to do |format|
      format.html do
        redirect_to screenings_url,
                    notice: 'Screening was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_screening
    @screening = Screening.find(params[:id])
  end

  def screening_params
    params[:time] = Time.parse(params[:time] << 'Z')
    params.permit(:time, :movie_id, :screen_id)
  end
end
