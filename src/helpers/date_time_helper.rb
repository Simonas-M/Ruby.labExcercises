require 'date'
require 'time'

# helper class for date and time
class DateTimeHelper
  # returns date if date is valid and raises error otherwise
  def self.valid_date?(str, format = '%Y-%m-%d')
    Date.strptime(str, format).to_time + Time.now.utc_offset
  end

  # returns added date and time
  def self.add_date_and_time(date, time)
    date.to_time.utc + (time[:hour] * 3_600 + time[:minute] * 60)
  end
end
