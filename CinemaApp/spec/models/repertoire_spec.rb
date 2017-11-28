# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repertoire, type: :model do
  fixtures :all
  # include RepertoireMatchers #TODO
  before(:each) do
    cinema = cinemas(:cinema)
    @repertoire = repertoires(:repertoire)
    @movie = movies(:inception)
    screen = screens(:screen)
    diff_screen = Screen.create(title: 'different',
                                seat_count: 20,
                                cinema_id: cinema.id)
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

  it 'should get only its same cinema screenings' do
    other_screening = Screening.create!(
      movie: @movie,
      screen: Screen.create!(cinema: Cinema.create!)
    )
    expect(@repertoire.screenings).not_to include(other_screening)
  end

  it 'should add new screening' do
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
    expect { @repertoire.del_screening_by_id(9) }
      .to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'should delete existing screening' do
    @repertoire.add_screening(new_screening: @screening)
    @repertoire.del_screening_by_id(Screening.find_by(@screening).id)
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

  it 'should not destroy screening if repertoire doesnt include it' do
    screening = Screening.create!(
      movie: Movie.create,
      screen: Screen.create
    )
    @repertoire.del_screening_by_id(screening.id)
    expect(Screening.find(screening.id)).to be
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
    movie = Movie.create!
    @repertoire.add_movie(movie: movie)
    @repertoire.del_movie(movie: movie)
    expect(@repertoire.movies.exists?(movie.id)).to be false
  end

  it 'should not delete movie if it doesnt exist in repertoire' do
    movie = Movie.create!
    expect { @repertoire.del_movie(movie: movie) }
      .to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'should not delete movie if it doesnt exist in repertoire' do
    movie = Movie.create!
    RepertoireMovie.create!(
      repertoire: Repertoire.create,
      movie: movie
    )
    expect { @repertoire.del_movie(movie: movie) }
      .to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'should raise when trying to delete non existing movie' do
    not_in_repertoire = Movie.create
    expect { @repertoire.del_movie(movie: not_in_repertoire) }
      .to raise_error(ActiveRecord::RecordNotFound)
  end
end
