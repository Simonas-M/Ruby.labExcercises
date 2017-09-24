require 'time'
require_relative '../src/movie/movie_screening.rb'
require_relative '../src/cinema_repertoire.rb'
require_relative '../src/cinema_screen.rb'
require_relative './helpers/movie_helper.rb'

describe ':Repertoire:' do
  before(:each) do
    @repertoire = CinemaRepertoire.new
    @screening =  MovieScreening.new(movie: MovieHelper.create,
                                     cinema_screen: CinemaScreen.new(
                                       name: 'test',
                                       seat_count: 20
                                     ),
                                     time: Time.now)
    @overlaping = MovieScreening.new(movie: MovieHelper.create,
                                     cinema_screen: CinemaScreen.new(
                                       name: 'test',
                                       seat_count: 20
                                     ),
                                     time: Time.now)
    @different_screen = MovieScreening.new(movie: MovieHelper.create,
                                           cinema_screen: CinemaScreen.new(
                                             name: 'different',
                                             seat_count: 20
                                           ),
                                           time: Time.now)
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

  it 'should add a new movie' do
  end

  it 'should not add same movie' do
  end

  it 'should delete existing movie' do
  end

  it 'should raise when trying to delete non existing movie' do
  end

end
