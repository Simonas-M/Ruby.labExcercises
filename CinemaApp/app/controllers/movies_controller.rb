# frozen_string_literal: true

# Controller for Movies
class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show destroy]

  # GET /movies
  def index
    @movies = Movie.all
  end

  # GET /movies/1
  def show; end

  def create_movie
    @movie = Movie.new
    info = Info.new(
      movie_info_params.merge(movie: movie)
    )
    description = Description.new(
      movie_description_params.merge(movie: movie)
    )
    info.save && description.save && movie.save
  end

  # POST /movies
  def create
    if create_movie
      respond(movie, 'Movie was successfully created.')
    else
      respond(movies_new_path, 'An error occured, please try again')
    end
  rescue ActionController::ParameterMissing
    respond(movies_new_path, 'Please check if all fields are filled')
  end

  # DELETE /movies/1
  def destroy
    movie.destroy
    if movie.destroyed?
      respond(movies_path, 'Movie was successfully destroyed')
    else
      respond(movies_path, 'An error occured, movie not deleted')
    end
  end

  private

  attr_reader :movie

  # Use callbacks to share common setup or constraints between actions.
  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_info_params
    validate_params(:duration, :release_date, :rating)
    params[:rating] = Rating.find(params[:rating])
    params[:duration] = DatetimeHelper.parse_time_to_seconds(params[:duration])
    params.permit!.slice(:duration, :rating, :release_date)
  end

  def movie_description_params
    validate_params(:title, :summary, :genre)
    params[:genre] = Genre.find(params[:genre])
    params.permit!.slice(:title, :summary, :genre)
  end
end
