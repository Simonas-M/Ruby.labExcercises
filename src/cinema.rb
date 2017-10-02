require_relative './cinema_repertoire.rb'

# Class for central cinema object
class Cinema
  attr_reader :location, :cinema_screens
  def initialize(location:, cinema_screens:)
    @location = location
    @cinema_screens = cinema_screens
    @repertoire = CinemaRepertoire.new
  end
end
