require_relative 'movie_genre.rb'

# class for Movie description
class MovieDescription
  attr_reader :title, :genre, :summary
  def initialize(title:, genre:, summary:)
    raise 'no such genre' unless
    MovieGenres.include?(genre)

    @title = title
    @genre = genre.to_sym.upcase
    @summary = summary
  end
end
