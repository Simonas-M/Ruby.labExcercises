require 'rails_helper'

RSpec.describe Repertoire, type: :model do
  fixtures :all
  # include RepertoireMatchers #TODO
  before(:each) do
    cinema = Cinema.create
    @repertoire = Repertoire.create(cinema_id: cinema.id)
    @movie = Movie.create
    RepertoireMovie.create(
      repertoire_id: @repertoire.id,
      movie_id: @movie.id
    )
    Description.create(
      title: 'title',
      summary: 'summary',
      genre_id: Genre.create(name: 'genre').id,
      movie_id: @movie.id
    )
    Info.create(
      duration: 1000,
      release_date: Time.at(1_531_411_120),
      rating_id: Rating.create(name: 'PG').id,
      movie_id: @movie.id
    )
    screen = Screen.create(title: 'test', seat_count: 20, cinema_id: cinema.id)
    diff_screen = Screen.create(title: 'different', seat_count: 20, cinema_id: cinema.id)
    @screening =  { movie_id: @movie.id,
                    screen_id: screen.id,
                    time: Time.new(2017, 11, 1, 12) }
    @overlaping = { movie_id: @movie.id,
                    screen_id: screen.id,
                    time: Time.new(2017, 11, 1, 12) }
    @non_overlaping = { movie_id: @movie.id,
                        screen_id: screen.id,
                        time: Time.new(2017, 12, 1, 12) }
    @different_screen = { movie_id: @movie.id,
                          screen_id: diff_screen.id,
                          time: Time.new(2017, 11, 1, 12) }
  end

  it 'should add new screening' do
    p movies(:inception)
    @repertoire.add_screening(new_screening: @screening)
    expect(Screening.exists?(@screening)).to be true
  end

  it 'should add multiple screenings' do
    @repertoire.add_screenings(screenings: [@screening, @non_overlaping])
    expect(Screening.exists?(@screening)).to be true
    expect(Screening.exists?(@non_overlaping)).to be true
  end

  it 'should raise when trying to delete non existing screening' do
    @repertoire.add_screening(new_screening: @screening)
    expect { @repertoire.del_screening(screening_id: 9) }
      .to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'should delete existing screening' do
    @repertoire.add_screening(new_screening: @screening)
    @repertoire.del_screening(
      screening_id: Screening.find_by(@screening).id
    )
    expect(Screening.exists?(@screening)).to be false
  end

  it 'should not add a screening if time overlaps and screens are the same' do
    @repertoire.add_screening(new_screening: @screening)
    expect { @repertoire.add_screening(new_screening: @overlaping) }
      .to raise_error('cannot add overlaping screening')
  end

  it 'should add new screning if time overlap but screens are different' do
    @repertoire.add_screening(new_screening: @screening)
    @repertoire.add_screening(new_screening: @different_screen)
    expect(Screening.exists?(@screening)).to be true
    expect(Screening.exists?(@different_screen)).to be true
  end

  it 'should add new screning if time does not overlap' do
    @repertoire.add_screening(new_screening: @screening)
    @repertoire.add_screening(new_screening: @non_overlaping)
    expect(Screening.exists?(@non_overlaping)).to be true
  end

  it 'should add a new movie' do
    movie = Movie.create
    @repertoire.add_movie(movie: movie)
    expect(@repertoire.movies.exists?(movie.id)).to be true
  end

  it 'should add multiple movies' do
    movie = Movie.create
    movie2 = Movie.create
    @repertoire.add_movies(movies: [movie, movie2])
    expect(@repertoire.movies.exists?(movie.id)).to be true
    expect(@repertoire.movies.exists?(movie2.id)).to be true
  end

  it 'should not add same movie' do
    expect { @repertoire.add_movie(movie: @movie) }
      .to raise_error('cannot add existing movie')
  end

  it 'should delete existing movie' do
    movie = Movie.create
    @repertoire.add_movie(movie: movie)
    @repertoire.del_movie(movie: movie)
    expect(@repertoire.movies.exists?(movie.id)).to be false
  end

  it 'should raise when trying to delete non existing movie' do
    not_in_repertoire = Movie.create
    expect { @repertoire.del_movie(movie: not_in_repertoire) }
      .to raise_error(ActiveRecord::RecordNotFound)
  end
end
