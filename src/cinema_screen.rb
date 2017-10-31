# class for movie screen
class CinemaScreen
  attr_reader :name, :seat_count
  def initialize(name:, seat_count:)
    @name = name
    @seat_count = seat_count
  end

  def ==(other)
    name.eql?(other.name) &&
      seat_count.eql?(other.seat_count)
  end

  def to_s
    name
  end

  def to_hash
    {
      name: name,
      seat_count: seat_count
    }
  end

  def self.hash_create(_serial, hash)
    new(name: hash.fetch('name'), seat_count: hash.fetch('seat_count'))
  end
end
