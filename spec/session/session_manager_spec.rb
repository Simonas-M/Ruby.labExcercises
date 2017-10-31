require_relative '../../src/session/session_manager.rb'
require_relative '../../src/movie/movie_screening.rb'
require_relative '../../src/cinema_repertoire.rb'
require_relative '../../src/cinema_screen.rb'
require_relative '../../src/cinema.rb'

require_relative '../helpers/movie_helper.rb'

RSpec.describe 'SessionManager' do
  before(:each) do
    @cinema = Cinema.new
    @screens = [
      CinemaScreen.new(name: 'test', seat_count: 10),
      CinemaScreen.new(name: 'other', seat_count: 12)
    ]
    @movies = [
      MovieHelper.create(title: 'test_movie'),
      MovieHelper.create(title: 'new_movie')
    ]
    @screenings = [
      MovieScreening.new(movie: @movies[0],
                         cinema_screen: @screens[1],
                         time: Time.new(2017, 11, 1))
    ]
    @storage = spy('FakeStorage')
    @manager = SessionManager.new(@cinema, @storage)
    @session_manager = spy('manager')
  end

  it 'should save serialized objects to json file' do
    @cinema.add_screen(@screens[0])
    @cinema.add_screens([@screens[1]])
    @cinema.repertoire.add_movies(movies: @movies)
    @cinema.repertoire.add_screenings(screenings: @screenings)
    serialized_cinema = %({"Movie":{"#{@movies[0].object_id}":{"info_id":\
"#{@movies[0].info.object_id}","description_id":\
"#{@movies[0].description.object_id}"},"#{@movies[1].object_id}":{"info_id":\
"#{@movies[1].info.object_id}","description_id":\
"#{@movies[1].description.object_id}"}},"MovieInfo":\
{"#{@movies[0].info.object_id}":{"rating":"PG","duration":10000,"release_date":\
"2015-01-01","crew_id":"#{@movies[0].info.crew.object_id}"},\
"#{@movies[1].info.object_id}":{"rating":"PG","duration":10000,"release_date":\
"2015-01-01","crew_id":"#{@movies[1].info.crew.object_id}"}},"CinemaScreen":\
{"#{@screens[0].object_id}":{"name":"test","seat_count":10},\
"#{@screens[1].object_id}":{"name":"other","seat_count":12}},"MovieCrew":\
{"#{@movies[0].info.crew.object_id}":{"directors":["Uncle"],"writers":["Bob"],"\
actors":["Rick","Morty"]},"#{@movies[1].info.crew.object_id}":{"directors":["Un\
cle"],"writers":["Bob"],"actors":["Rick","Morty"]}},"MovieScreening":{\
"#{@screenings[0].object_id}":{"movie_id":"#{@movies[0].object_id}","cinema_scr\
een_id":"#{@screens[1].object_id}","time":1509487200,"available_seat_count":12}\
},"MovieDescription":{"#{@movies[0].description.object_id}":{"title":"test_movi\
e","genre":"ACTION","summary":"summary"},"#{@movies[1].description.object_id}":\
{"title":"new_movie","genre":"ACTION","summary":"summary"}}})
    @manager.save_session
    expect(@storage).to have_received(:write).with(serialized_cinema)
  end

  it 'should restore session' do
    serialized_schema = %({"Movie":{"33512400":{"info_id":"33512480","descripti\
on_id":"33525660"}},"MovieInfo":{"33512480":{"rating":"PG13","duration":1234,"r\
elease_date":"2000-01-01","crew_id":"33512540"}},"CinemaScreen":{"33510940":{"n\
ame":"screen`","seat_count":2}},"MovieCrew":{"33512540":{"directors":["directpr\
"],"writers":["writer"],"actors":["actor"]}},"MovieScreening":{"33505740":{"mov\
ie_id":"33512400","cinema_screen_id":"33510940","time":1355328000,"available_se\
at_count":2}},"MovieDescription":{"33525660":{"title":"test","genre":"ACTION","\
summary":"summary"}}})
    allow(@storage).to receive(:read_all).and_return(serialized_schema)
    @manager.restore_session
    movie = @cinema.repertoire.movies.first
    expect(movie.info.rating).to eq :PG13
    expect(movie.description.title).to eq 'test'
    screening = @cinema.repertoire.movie_screenings.first
    expect(screening.movie).to eq movie
    expect(@cinema.screens.first.name).to eq 'screen`'
  end

  it 'should raise if file format is incorrect' do
    allow(@storage).to receive(:read_all).and_return('bad/forMat')
    expect { @manager.restore_session }.to raise_error('BAD_JSON_FORMAT')
  end
end

# fake storage stub
class FakeStorage
  def write; end

  def read_all; end
end
