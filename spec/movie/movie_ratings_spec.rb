require_relative '../../src/movie/movie_ratings.rb'

describe '::Movie Ratings' do
  it 'should return true if movie rating exists' do
    expect(MovieRatings.include?(:PG)).to be true
  end
  it "should return false if movie rating doesn't exist" do
    expect(MovieRatings.include?(:NO)).to be false
  end
  it 'should accept strings as arguments' do
    expect(MovieRatings.include?('r')).to be true
  end
  it 'should be frozen' do
    before = MovieRatings::RATINGS
    expect { MovieRatings::RATINGS = 'not ratings' }.to raise_error
    expect(MovieRatings::RATINGS).to eq(before)
  end
end
