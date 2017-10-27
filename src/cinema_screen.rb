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
    %({"name":"#{name}",\
    "seat_count": #{seat_count}})
  end

  def self.hash_create(_serial, hash)
    new(name: hash.fetch(:name), seat_count: hash.fetch(:seat_count))
  end
end
