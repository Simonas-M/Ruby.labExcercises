require_relative './helpers/movie_screening_helper.rb'

# class for movie screening management
class CinemaRepertoire
  def initialize
    @movies = []
    @movie_screenings = []
  end

  def movies
    @movies.to_enum
  end

  def movie_screenings
    @movie_screenings.to_enum
  end

  # methods for movie management
  def add_movie(movie:)
    raise 'cannot add existing movie' if
      movies.include?(movie)
    @movies.push(movie)
  end

  def del_movie(movie:)
    raise 'cannot delete non existing movie' unless
      movies.include?(movie)
    @movies.delete(movie)
  end

  # methods for movie screening management
  # right now this can add undefined onjects and mess things up
  def add_screening(new_screening:)
    raise 'cannot add overlaping screening' if overlaps?(new_screening)
    @movie_screenings.push(new_screening)
  end

  def del_screening(screening:)
    raise 'no such screening found' unless
      movie_screenings.include?(screening)
    @movie_screenings.delete(screening)
  end

  private

  def overlaps?(new_screening)
    movie_screenings.any? do |screening|
      MovieScreeningHelper.overlaps?(screening, new_screening)
    end
  end
end
