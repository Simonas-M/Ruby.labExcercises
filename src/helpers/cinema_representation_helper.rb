# class for creating perfect string representations for cinema objects
class CinemaRepresentationHelper
  def self.stringify_movie(info, description)
    %(#{description.title.capitalize} (#{info.release_date.year})
#{info.rating} | #{hour_minute(info.duration)} | \
#{description.genre} | #{iso_date_time(info.release_date)}
#{description.summary}
-----------------------------------------------------------)
  end

  def self.stringify_screening(screening)
    movie = screening.movie
    %(#{movie.info.title.capitaize}
#{movie.info.rating} | #{screening.cinema_screen.name}
#{full_date(screening.time)})
  end

  def self.hour_minute(time)
    format_time(time, '%Hh %Mmin')
  end

  def self.iso_date_time(time)
    format_time(time, '%Y-%m-%d')
  end

  def self.full_date(time)
    format_time(time, '%Y-%m-%d %Hh %Mmin')
  end

  def self.format_time(time, format)
    Time.at(time).utc.strftime(format)
  end
end