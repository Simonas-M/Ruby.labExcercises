# frozen_string_literal: true

require 'time'

# Screenings controller
class ScreeningsController < ApplicationController
  before_action :set_screening, only: %i[show destroy]
  before_action :set_repertorie, only: %i[create]

  attr_reader :screenings

  # GET /screenings
  def index
    @screenings = Screening.all
  end

  # GET /screenings/1
  def show; end

  # POST /screenings
  def create
    scr_params = screening_params
    if repertoire.add_screening(new_screening: scr_params)
      respond(
        Screening.find_by(scr_params), 'Screening was successfully created'
      )
    else
      respond(screenings_new_path, repertoire.errors[:screening])
    end
  rescue ActionController::ParameterMissing
    respond(screenings_new_path, 'Please check if all fields are filled')
  end

  # DELETE /screenings/1
  def destroy
    screening.destroy
    if screening.destroyed?
      respond(screenings_url, 'Screening was successfully destroyed')
    else
      respond(
        screenings_url, 'An error occured, screening not deleted'
      )
    end
  end

  private

  attr_reader :screening, :repertoire

  # Use callbacks to share common setup or constraints between actions.
  def set_screening
    @screening = Screening.find(params.fetch(:id))
  end

  def set_repertorie
    @repertoire = Repertoire.last
  end

  def screening_params
    validate_params(:time, :movie_id, :screen_id)
    params[:time] = Time.parse(params.fetch(:time) << 'Z')
    params.permit(:time, :movie_id, :screen_id)
  end
end
