require_relative '../../helpers/date_time_helper.rb'

# returns a Movie object
def create_movie
  description = create_movie_description
  info = create_movie_info
  Movie.new(info, description)
end

# returns a MovieInfo object
def create_movie_info
  UI.send_message 'Enter movie rating:'
  rating = UI.receive_list_item(MovieRatings::RATINGS)
  UI.send_message 'Enter movie duration:'
  duration = UI.receive_integer_input
  UI.send_message 'Enter movie release date in YYYY-MM-DD format:'
  release_date = UI.receive_date_input.to_time
  crew = create_movie_crew
  MovieInfo.new(rating: rating, duration: duration, release_date: release_date,
                crew: crew)
end

# returns a MovieDescription object
def create_movie_description
  UI.send_message 'Enter movie title:'
  title = UI.receive_input
  UI.send_message 'Choose movie genre:'
  genre = UI.receive_list_item(MovieGenres::GENRES)
  UI.send_message 'Enter movie summary:'
  summary = UI.receive_input
  MovieDescription.new(title: title, genre: genre, summary: summary)
end

# returns a MovieCrew object
def create_movie_crew
  UI.send_message 'Enter movie director(s): (to stop enter blank)'
  directors = UI.receive_multi_input
  UI.send_message 'Enter movie writer(s): (to stop enter blank)'
  writers = UI.receive_multi_input
  UI.send_message 'Enter movie actor(s): (to stop enter blank)'
  actors = UI.receive_multi_input
  MovieCrew.new(directors: directors, writers: writers, actors: actors)
end

def create_movie_screening
  UI.send_message 'Select movie:'
  movie = UI.receive_list_item(@cinema.repertoire.movies)
  UI.send_message 'Select cinema screen:'
  screen = UI.receive_list_item(@cinema.screens)
  UI.send_message 'Enter screening date:'
  date = UI.receive_date_input
  UI.send_message 'Enter screening time:'
  time = UI.receive_time_input
  date_time = DateTimeHelper.add_date_and_time(date, time)
  MovieScreening.new(movie: movie, cinema_screen: screen, time: date_time)
end

def create_cinema_screen
  UI.send_message 'Enter cinema screen name:'
  name = UI.receive_input
  UI.send_message 'Enter seat count:'
  seat_count = UI.receive_integer_input
  CinemaScreen.new(name: name, seat_count: seat_count)
end
