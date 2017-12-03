# frozen_string_literal: true

# class for movie screen
class Screen < ApplicationRecord
  belongs_to :cinema

  def ==(other)
    title.eql?(other.title) &&
      seat_count.eql?(other.seat_count)
  end

  def to_s
    title
  end
end
