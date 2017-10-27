require_relative '../../src/movie/movie_description.rb'
require_relative '../../src/movie/movie_genre.rb'

RSpec.describe 'MovieDescription' do
  before(:each) do
    @description_args = {
      title: 'Stranger Things',
      genre: :MYSTERY,
      summary: 'summary'
    }
  end
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

  it 'should serialize to json' do
    movie_description = MovieDescription.new(@description_args)
    serialized_hash = JSON.parse(movie_description.to_json)
    expect(serialized_hash['title']).to eq(movie_description.title)
    expect(serialized_hash['genre']).to eq(movie_description.genre.to_s)
    expect(serialized_hash['summary']).to eq(movie_description.summary)
  end

  it 'should deserialize hash to object' do
    from_hash = MovieDescription.hash_create(nil, @description_args)
    expect(from_hash.title).to eq 'Stranger Things'
    expect(from_hash.genre).to eq :MYSTERY
    expect(from_hash.summary).to eq 'summary'
  end
end
