# frozen_string_literal: true

# helper for movie screenings
class ScreeningHelper
  def self.overlaps?(existing_screening, new_screening)
    existing_time_range = extract_exsisting_time_range(existing_screening)
    new_time_range = extract_new_time_range(new_screening)

    DatetimeHelper.overlaps?(existing_time_range, new_time_range) &&
      existing_screening.screen.id == new_screening[:screen_id]
  end

  def self.extract_exsisting_time_range(screening)
    existing_start = screening.time
    existing_end = existing_start + screening.movie.duration
    existing_start..existing_end
  end

  def self.extract_new_time_range(screening)
    new_start = screening[:time]
    new_end = new_start + Movie.find(screening[:movie_id]).duration
    new_start..new_end
  end
end
