require 'time'
require_relative '../src/movie/movie_screening.rb'
require_relative '../src/cinema_repertoire.rb'
require_relative '../src/cinema_screen.rb'
require_relative './helpers/movie_helper.rb'

RSpec.describe 'CinemaRepertoire' do
  before(:each) do
    @repertoire = CinemaRepertoire.new
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
  it 'should add new screening' do
    @repertoire.add_screening(new_screening: @screening)
    expect(@repertoire.movie_screenings.include?(@screening)).to be true
  end

  it 'should delete existing screening' do
    @repertoire.add_screening(new_screening: @screening)
    expect { @repertoire.del_screening(screening: @different_screen) }
      .to raise_error('no such screening found')
  end

  it 'should raise when trying to delete non existing screening' do
    @repertoire.add_screening(new_screening: @screening)
    @repertoire.del_screening(screening: @screening)
    expect(@repertoire.movie_screenings.include?(@screening)).to be false
  end

  it 'should not add a screening if time overlaps and screens are the same' do
    @repertoire.add_screening(new_screening: @screening)
    expect { @repertoire.add_screening(new_screening: @overlaping) }
      .to raise_error('cannot add overlaping screening')
  end

  it 'should add new screning if time overlap but screens are different' do
    @repertoire.add_screening(new_screening: @screening)
    @repertoire.add_screening(new_screening: @different_screen)
    expect(@repertoire.movie_screenings.include?(@different_screen))
      .to be true
  end

  it 'should add new screning if time does not overlap' do
    @repertoire.add_screening(new_screening: @screening)
    @repertoire.add_screening(new_screening: @non_overlaping)
    expect(@repertoire.movie_screenings.include?(@non_overlaping))
      .to be true
  end

  it 'should add a new movie' do
    movie = MovieHelper.create
    @repertoire.add_movie(movie: movie)
    expect(@repertoire.movies.include?(movie)).to be true
  end

  it 'should add multiple movies' do
    movie = MovieHelper.create
    @repertoire.add_movies(movies: [movie, @non_overlaping])
    expect(@repertoire.movies.include?(movie)).to be true
    expect(@repertoire.movies.include?(@non_overlaping)).to be true
  end

  it 'should not add same movie' do
    movie = MovieHelper.create
    @repertoire.add_movie(movie: movie)
    expect { @repertoire.add_movie(movie: movie) }
      .to raise_error('cannot add existing movie')
  end

  it 'should delete existing movie' do
    movie = MovieHelper.create
    @repertoire.add_movie(movie: movie)
    @repertoire.del_movie(movie: movie)
    expect(@repertoire.movies.include?(movie)).to be false
  end

  it 'should raise when trying to delete non existing movie' do
    in_repertoire = MovieHelper.create
    not_in_repertoire = MovieHelper.create(title: 'Mist')
    @repertoire.add_movie(movie: in_repertoire)
    expect { @repertoire.del_movie(movie: not_in_repertoire) }
      .to raise_error('cannot delete non existing movie')
  end

  it 'should not be able to modify movies directly' do
    expect { @repertoire.movies.push(movie: 'movie') }
      .to raise_error(NoMethodError)
    expect(@repertoire.movies.include?('movie')).to be false
  end

  it 'should not be able to modify screenings directly' do
    expect { @repertoire.movie_screenings.push(movie: 'movie') }
      .to raise_error(NoMethodError)
    expect(@repertoire.movie_screenings.include?('movie')).to be false
  end
end
