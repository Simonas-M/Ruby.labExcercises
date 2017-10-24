require 'time_frame'

# helper for movie screenings
class MovieScreeningHelper
  def self.overlaps?(existing_screening, new_screening)
    time_frame = TimeFrame.new(min: existing_screening.time,
                               duration: existing_screening.movie.duration)
    new_time_frame = TimeFrame.new(min: new_screening.time,
                                   duration: new_screening.movie.duration)
    time_frame.overlaps?(new_time_frame) &&
      existing_screening.cinema_screen == new_screening.cinema_screen
  end
end
