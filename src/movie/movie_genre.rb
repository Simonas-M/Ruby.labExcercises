# class for storing movie genres
class MovieGenres
  GENRES = %I[ACTION ADVENTURE ANIMATION COMEDY CRIME DRAMA FANTASY
              HISTORICAL HORROR MYSTERY MUSICAL ROMANCE SCIFI THRILLER WAR
              WESTERN].freeze
  def self.include?(genre)
    GENRES.include?(genre.to_sym.upcase)
  end
end
MovieGenres.freeze
