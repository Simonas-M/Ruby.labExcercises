require_relative './serializer.rb'
require_relative './deserializer.rb'
require_relative './cinema_object_collection_helper.rb'
require 'json'

# class for storing user sessions
class SessionManager
  def initialize(cinema, storage)
    @cinema = cinema
    @storage = storage
    @serial = {}
  end

  def save_session
    collector = CinemaObjectCollectionHelper.new(@cinema)
    @storage.write(Serializer.serialize_all(collector.collect_all))
  end

  def restore_session
    parse_storage
    Deserializer.deserialize_sequence(@serial, %w[CinemaScreen MovieDescription
                                                  MovieCrew MovieInfo Movie
                                                  MovieScreening])
    restore_cinema_screens
    restore_movies
    restore_movie_screenings
  end

  private

  def restore_cinema_screens
    @cinema.add_screens(@serial['CinemaScreen'].values) if
      values? 'CinemaScreen'
  end

  def restore_movies
    @cinema.repertoire.add_movies(movies: @serial['Movie'].values) if
      values? 'Movie'
  end

  def restore_movie_screenings
    screenings = { screenings: @serial['MovieScreening'].values }
    @cinema.repertoire.add_screenings(screenings) if values? 'MovieScreening'
  end

  def values?(object_class)
    @serial[object_class]
  end

  def parse_storage
    @serial = JSON.parse(@storage.read_all)
  rescue JSON::ParserError
    raise 'BAD_JSON_FORMAT'
  end
end
