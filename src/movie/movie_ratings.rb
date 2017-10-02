# class for movie rating enums
class MovieRatings
  RATINGS = %I[G PG PG13 R PG17].freeze
  def self.include?(rating)
    RATINGS.include?(rating.to_sym.upcase)
  end
end
MovieRatings.freeze
