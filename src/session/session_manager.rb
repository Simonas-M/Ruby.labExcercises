# class for storing user sessions
class SessionManager
  def initialize(storage)
    @storage = storage
  end

  def save_session(*objects)
    storage.write(Serializer.serialize_all(objects)) # get all objects from Cinema
  end

  def restore_session
    parse_storage_file
    Deserializer.deserialize_sequence(json, 'CinemaScreen', 'MovieDescription',
                                      'MovieCrew', 'MovieInfo', 'Movie',
                                      'MovieScreening')
    # deserialize(@json, 'MovieDescription')
    # deserialize(@json, 'MovieCrew')
    # deserialize(@json, 'MovieInfo')
    # deserialize(@json, 'Movie')
    # deserialize(@json, 'MovieScreening')
    # create all objects and map them to their old object id's
    # start with cinema_screens, descriptions and crews
    # then infos
    # then movies
    # them movie_screenings
    # load created objects into Cinema
  end

  def parse_storage_file
    @json = JSON.parse(@storage.read_all)
  rescue JSON::ParserError
    puts 'bad file format'
  end
end
