require_relative './cinema_repertoire.rb'
require_relative './cinema_screen.rb'

# Class for central cinema object
class Cinema
  attr_reader :screens, :repertoire
  def initialize
    @screens = []
    @repertoire = CinemaRepertoire.new
  end

  def add_screen(cinema_screen)
    @screens.push(cinema_screen)
  end

  def add_screens(cinema_screens)
    cinema_screens.each { |screen| @screens.push(screen) }
  end
end
