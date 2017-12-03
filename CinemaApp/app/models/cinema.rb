# frozen_string_literal: true

# Class for central cinema object model
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
      add_screen(screen_hash)
    end
  end
end
