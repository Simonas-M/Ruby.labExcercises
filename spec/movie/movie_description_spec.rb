require_relative '../../src/movie/movie_genre.rb'
require_relative '../../src/movie/movie_description.rb'

describe '::Movie Description' do
  it 'should create succesfully when genre is included in MovieGenres' do
    movie_description = MovieDescription.new(
      title: 'Transformers 19: New Beggining',
      genre: :fantasy,
      summary: 'Long before there were transformers there was the CUBE...'
    )
    expect(movie_description).to be
  end
  it 'should raise error when genre is not included in MovieGenres' do
    description_args = {
      title: 'Transformers 19: New Beggining',
      genre: :donald_duck,
      summary: 'Long before there were transformers there was the CUBE...'
    }
    expect { movie_description.new(description_args) }.to raise_error
  end
end
