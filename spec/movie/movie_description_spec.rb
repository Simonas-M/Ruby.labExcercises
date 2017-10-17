require_relative '../../src/movie/movie_genre.rb'
require_relative '../../src/movie/movie_description.rb'

RSpec.describe 'MovieDescription' do
  it 'should create succesfully when genre is included in MovieGenres' do
    movie_description = MovieDescription.new(
      title: 'Transformers 19: New Beggining',
      genre: 'fanTasy',
      summary: 'long summary'
    )
    expect(movie_description.title).to eq 'Transformers 19: New Beggining'
    expect(movie_description.genre).to eq :FANTASY
    expect(movie_description.summary).to eq 'long summary'
  end
  it 'should raise error when genre is not included in MovieGenres' do
    description_args = {
      title: 'Transformers 19: New Beggining',
      genre: :donald_duck,
      summary: 'long summary'
    }
    expect { MovieDescription.new(description_args) }
      .to raise_error('no such genre')
  end
end
