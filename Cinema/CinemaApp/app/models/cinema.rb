# Class for central cinema object
class Cinema < ApplicationRecord
  has_many :screens
  has_one :repertoire

  def add_screen(title:, seat_count:)
    Screen.create(
      title: title,
      seat_count: seat_count,
      cinema_id: id
    )
  end

  def add_screens(cinema_screens)
    cinema_screens.each do |screen_hash|
      add_screen(
        title: screen_hash[:title],
        seat_count: screen_hash[:seat_count]
      )
    end
  end
end
