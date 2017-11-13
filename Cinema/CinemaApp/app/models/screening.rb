# movie session class for Movie repertoire
class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :screen
  has_many :tickets

  before_create do
    self.available_seat_count = screen.seat_count
  end

  def reserve(seat_count)
    seat_count = Integer(seat_count)
    raise 'not enough free seats available' unless
      seat_count <= available_seat_count
    self.available_seat_count -= seat_count
  end

  def free(seat_count)
    seat_count = Integer(seat_count)
    raise "cannon free #{seat_count} seats" unless
    seat_count <= (screen.seat_count - self.available_seat_count)
    self.available_seat_count += seat_count
  end

  def available?(seat_count)
    seat_count <= available_seat_count
  end

  def to_s
    RepresentationHelper.stringify_screening(self)
  end
end
