# frozen_string_literal: true

# class for movie screening management
class Repertoire < ApplicationRecord
  belongs_to :cinema
  has_many :repertoire_movies
  has_many :movies, through: :repertoire_movies

  def screenings
    Screening.joins(:movie)
             .where(screen_id: Screen.where(cinema_id: cinema.id).ids)
  end

  # methods for movie management
  def add_movie(movie:)
    movie_id = movie.id
    raise 'cannot add existing movie' if
      movies.any? { |mov| mov.id == movie_id }
    RepertoireMovie.create(
      repertoire_id: id,
      movie_id: movie_id
    )
  end

  def add_movies(movies:)
    movies.each { |movie| add_movie(movie: movie) }
  end

  def del_movie(movie:)
    RepertoireMovie.find_by!(
      movie_id: movie.id,
      repertoire_id: id
    ).destroy
  end

  # methods for movie screening management
  # right now this can add undefined onjects and mess things up
  def add_screening(new_screening:)
    raise 'cannot add overlaping screening' if overlaps?(new_screening)
    Screening.create(new_screening)
  end

  def add_screenings(screenings:)
    screenings.each { |screening| add_screening(new_screening: screening) }
  end

  def del_screening_by_id(screening_id)
    screening = Screening.find(screening_id)
    screening.destroy if screenings.include?(screening)
  end

  private

  def overlaps?(new_screening)
    screenings.any? do |screening|
      ScreeningHelper.overlaps?(screening, new_screening)
    end
  end
end
