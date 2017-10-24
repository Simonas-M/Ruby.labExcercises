require_relative '../../src/movie/movie_screening.rb'
require_relative '../../src/helpers/movie_screening_helper.rb'
require_relative './movie_helper.rb'
require_relative '../../src/cinema_screen.rb'
require 'time'

RSpec.describe 'MovieScreeningHelper' do
  before(:each) do
    @screening =  MovieScreening.new(movie: MovieHelper.create,
                                     cinema_screen: CinemaScreen.new(
                                       name: 'test',
                                       seat_count: 20
                                     ),
                                     time: Time.new(2017, 11, 1, 12))
    @overlaping = MovieScreening.new(movie: MovieHelper.create,
                                     cinema_screen: CinemaScreen.new(
                                       name: 'test',
                                       seat_count: 20
                                     ),
                                     time: Time.new(2017, 11, 1, 12))
    @non_overlaping = MovieScreening.new(movie: MovieHelper.create,
                                         cinema_screen: CinemaScreen.new(
                                           name: 'test',
                                           seat_count: 20
                                         ),
                                         time: Time.new(2017, 12, 1, 12))
    @different_screen = MovieScreening.new(movie: MovieHelper.create,
                                           cinema_screen: CinemaScreen.new(
                                             name: 'different',
                                             seat_count: 20
                                           ),
                                           time: Time.new(2017, 11, 1, 12))
  end
  it 'should not add a screening if time overlaps and screens are the same' do
    expect(MovieScreeningHelper.overlaps?(@screening, @overlaping))
      .to be true
  end

  it 'should add new screning if time overlap but screens are different' do
    expect(MovieScreeningHelper.overlaps?(@screening, @different_screen))
      .to be false
  end

  it 'should add new screning if time does not overlap' do
    expect(MovieScreeningHelper.overlaps?(@screening, @non_overlaping))
      .to be false
  end
end
