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

  def to_hash
    {
      title: title,
      genre: genre.to_s,
      summary: summary
    }
  end

  def self.hash_create(_serial, hash)
    new(title: hash.fetch('title'),
        genre: hash.fetch('genre'),
        summary: hash.fetch('summary'))
  end
end
