# frozen_string_literal: true

# Controller for Movies
class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show destroy]

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
  end

  # GET /movies/1
  # GET /movies/1.json
  def show; end

  # POST /moviess
  # POST /movies.json
  def create
    @movie = Movie.new
    info = Info.new(
      movie_info_params.merge(movie: @movie)
    )
    description = Description.new(
      movie_description_params.merge(movie: @movie)
    )

    respond_to do |format|
      if @movie.save
        redirect_and_notify(
          format,
          @movie,
          'Movie was successfully created.'
        )
      else
        redirect_and_notify(
          format,
          movies_new_path,
          'An error occured, please try again'
        )
      end
    end
  rescue ActionController::ParameterMissing
    return rescue_bad_request
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    respond_to do |format|
      redirect_and_notify(
        format,
        movies_url,
        'Movie was successfully destroyed'
      )
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_info_params
    validate_params(:duration, :release_date, :rating)
    params[:rating] = Rating.find(params[:rating])
    duration = params[:duration].split(':')
    params[:duration] = DatetimeHelper.to_seconds(
      hours: Integer(duration[0]),
      minutes: Integer(duration[1])
      )
    params.permit!.slice(:duration, :rating, :release_date)
  end

  def validate_params(*parameters)
    parameters.each { |param| params.require(param) }
  end

  def movie_description_params
    validate_params(:title, :summary, :genre)
    params[:genre] = Genre.find(params[:genre])    
    params.permit!.slice(:title, :summary, :genre)
  end

  def rescue_bad_request
    respond_to do |format|
      redirect_and_notify(
        format,
        movies_new_path,
        'Please check if all fields are filled')
      render_json(
        format,
        'Please check if all fields are filled',
        :bad_request)
    end
  end

  def redirect_and_notify(format, path, notice)
    format.html { redirect_to(path, notice: notice) }
  end

  def render_json(format, json, status)
    format.json { render json: json, status: status }
  end
end
