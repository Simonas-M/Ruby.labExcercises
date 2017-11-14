require_relative '../../src/session/session_manager.rb'
require_relative '../../src/movie/movie_screening.rb'
require_relative '../../src/session/file_storage.rb'
require_relative '../../src/cinema_repertoire.rb'
require_relative '../../src/cinema_screen.rb'
require_relative '../../src/cinema.rb'

require_relative '../helpers/movie_helper.rb'

RSpec.describe 'SessionManager' do
  before(:each) do
    @cinema = Cinema.new
    @screens = [
      CinemaScreen.new(name: 'test', seat_count: 10)
    ]
    @movies = [
      MovieHelper.create(title: 'test movie')
    ]
    @screenings = [
      MovieScreening.new(movie: @movies[0],
                         cinema_screen: @screens[0],
                         time: Time.new(2017, 11, 1))
    ]
    @storage = FileStorage.new('./spec/data/serialized_cinema.json')
    @manager = SessionManager.new(@cinema, @storage)
    @session_manager = spy('manager')
  end

  it 'should save serialized objects to json file' do
    @cinema.add_screen(@screens[0])
    @cinema.add_screens([@screens[0]])
    @cinema.repertoire.add_movies(movies: @movies)
    @cinema.repertoire.add_screenings(screenings: @screenings)
    @manager.save_session
    @storage.end
    expect(File.new('./spec/data/serialized_cinema.json').read)
      .to eq(File.new('./spec/data/serialized_correct.json').read)
  end

  it 'should restore session' do
    @storage = FileStorage.new('./spec/data/serialized_correct.json')
    @manager.restore_session
    movie = @cinema.repertoire.movies.first
    expect(movie.info.rating).to eq :PG
    expect(movie.description.title).to eq 'Test Movie'
    screening = @cinema.repertoire.movie_screenings.first
    expect(screening.movie).to eq movie
    expect(@cinema.screens.first.name).to eq 'test'
  end

  it 'should raise if file format is incorrect' do
    allow(@storage).to receive(:read_all).and_return('bad/forMat')
    expect { @manager.restore_session }.to raise_error('BAD_JSON_FORMAT')
  end
end
