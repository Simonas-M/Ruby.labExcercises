# class for movie screen
class CinemaScreen
  attr_reader :name, :seat_count
  def initialize(name:, seat_count:)
    @name = name
    @seat_count = seat_count
  end

  def ==(other)
    @name == other.name &&
      @seat_count == other.seat_count
  end

  def to_json
    %(
    {"name": "#{name}",\
    "seat_count": #{seat_count}}).chomp
  end

  def self.create_from_hash(_serial, hash)
    new(name: hash['name'], seat_count: hash['seat_count'])
  end
end
