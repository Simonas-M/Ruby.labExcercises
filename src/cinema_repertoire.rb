require 'time_frame'

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
      @movies.include?(movie)
    @movies.push(movie)
  end

  def del_movie(movie:)
    raise 'cannot delete non existing movie' unless
      @movies.include?(movie)
    @movies.delete(movie)
  end

  # methods for movie screening management
  # right now this can add undefined onjects and mess things up
  def add_screening(new_screening:)
    raise 'cannot add overlaping screening' if
      @movie_screenings.any? { |screening| colision?(screening, new_screening) }
    @movie_screenings.push(new_screening)
  end

  def del_screening(screening:)
    raise 'no such screening found' unless
      @movie_screenings.include?(screening)
    @movie_screenings.delete(screening)
  end

  private

  def colision?(screening, new_screening)
    time_frame1 = TimeFrame.new(min: screening.time,
                                duration: screening.movie.duration)
    time_frame2 = TimeFrame.new(min: new_screening.time,
                                duration: new_screening.movie.duration)
    time_frame1.overlaps?(time_frame2) &&
      screening.cinema_screen == new_screening.cinema_screen
  end
end
