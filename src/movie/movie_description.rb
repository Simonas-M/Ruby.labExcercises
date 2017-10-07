require_relative 'movie_genre.rb'

# class for Movie description
class MovieDescription
  attr_reader :title, :genre, :summary
  def initialize(title:, genre:, summary:)
    raise ArgumentError.new(genre, 'no such genre') unless
    MovieGenres.include?(genre)

    @title = title.to_s
    @genre = genre.to_sym.upcase
    @summary = summary.to_s
  end
end
