class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :destroy]

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # POST /moviess
  # POST /movies.json
  def create
    @movie = Movie.new
    duration = params[:duration].split(':')
    @info = Info.new(
      duration: Integer(duration[0]) * 3600 + Integer(duration[1]) * 60,
      release_date: Date.parse(params[:release_date]),
      rating: Rating.find(params[:rating]),
      movie: @movie
    )
    @description = Description.new(
      title: params[:title],
      summary: params[:summary],
      genre: Genre.find(params[:genre]),
      movie: @movie
    )

    respond_to do |format|
      if @movie.save && @info.save && @description.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    Movie.transaction do
      @movie.description.destroy
      @movie.info.destroy
      @movie.destroy
    end
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.fetch(:movie, {})
    end
end
