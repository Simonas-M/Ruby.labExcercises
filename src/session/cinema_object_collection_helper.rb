# Class for getting required objects for data serialization
class CinemaObjectCollectionHelper
  def initialize(cinema)
    @cinema = cinema
  end

  def collect_all
    [
      collect_movies,
      collect_movie_infos,
      collect_cinema_screens,
      collect_movie_info_crews,
      collect_movie_screenings,
      collect_movie_descriptions
    ].flatten
  end

  def collect_cinema_screens
    @cinema.screens
  end

  def collect_movies
    movies = []
    @cinema.repertoire.movies.each do |movie|
      movies.push(movie)
    end
  end

  def collect_movie_screenings
    screenings = []
    @cinema.repertoire.movie_screenings.each do |screening|
      screenings.push(screening)
    end
  end

  def collect_movie_infos
    movie_infos = []
    @cinema.repertoire.movies.each do |movie|
      movie_infos.push(movie.info)
    end
    movie_infos
  end

  def collect_movie_descriptions
    movie_descriptions = []
    @cinema.repertoire.movies.each do |movie|
      movie_descriptions.push(movie.description)
    end
    movie_descriptions
  end

  def collect_movie_info_crews
    movie_info_crews = []
    @cinema.repertoire.movies.each do |movie|
      movie_info_crews.push(movie.info.crew)
    end
    movie_info_crews
  end
end
