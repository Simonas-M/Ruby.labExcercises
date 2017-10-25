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

  def to_json
    %({"title": "#{title}",\
    "genre": "#{genre}",\
    "summary": "#{summary}"}).chomp
  end

  def self.create_from_hash(_serial, hash)
    new(title: hash['title'],
        genre: hash['seat_count'],
        summary: hash['summary'])
  end
end
