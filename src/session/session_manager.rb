require_relative './serializer.rb'
require_relative './deserializer.rb'
require 'json'

# class for storing user sessions
class SessionManager
  def initialize(storage)
    @storage = storage
  end

  def save_session(objects)
    @storage.write(Serializer.serialize_all(objects))
  end

  def restore_session
    parse_storage
    Deserializer.deserialize_sequence(@json, %w[CinemaScreen MovieDescription
                                                MovieCrew MovieInfo Movie
                                                MovieScreening])
    @json
  end

  private

  def parse_storage
    @json = JSON.parse(@storage.read_all)
  rescue JSON::ParserError
    puts 'bad file format'
  end
end
