# frozen_string_literal: true

require_relative './datetime_helper.rb'

# class helper for ticket manager
class TicketPriceCalculator
  BASE_PRICE = 3
  BASE_DISCOUNT = 0.087
  BASE_DISCOUNT_START = 3
  EVERY_NTH_TICKET = 7

  def self.calculate_yearly_discount(release_date)
    current_year = DatetimeHelper.current_year
    release_year = release_date.year
    if release_year < current_year - BASE_DISCOUNT_START
      BASE_DISCOUNT * (current_year - release_year)
    else
      0
    end
  end

  def self.calculate_ticket_price(movie_screening)
    movie_info = movie_screening.movie.info
    release_date = movie_info.release_date
    duration = movie_info.duration
    (BASE_PRICE * (Float(duration) / 3600) -
      calculate_yearly_discount(release_date)).round(2)
  end

  def self.free_ticket_elllegible?(count)
    return false if count.zero?
    (count % EVERY_NTH_TICKET).zero?
  end
end
