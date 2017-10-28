require_relative './cinema_repertoire.rb'

# Class for central cinema object
class Cinema
  attr_reader :screens, :repertoire
  def initialize
    @screens = []
    @repertoire = CinemaRepertoire.new
  end
end
