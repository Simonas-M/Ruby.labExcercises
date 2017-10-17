require_relative '../../src/movie/movie_genre.rb'

RSpec.describe 'MovieGenres' do
  it 'should return true if movie genre exists' do
    expect(MovieGenres.include?(:action)).to be true
  end
  it "should return false if movie genre doesn't exist" do
    expect(MovieGenres.include?(:walking)).to be false
  end
  it 'should accept strings as arguments' do
    expect(MovieGenres.include?('action')).to be true
  end
  it 'should be frozen' do
    before = MovieGenres::GENRES
    expect { MovieGenres::GENRES = 'not genres' }.to raise_error
    expect(MovieGenres::GENRES).to eq(before)
  end
end
