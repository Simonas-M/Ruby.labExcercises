require_relative './UI/console_user_interface.rb'
require_relative './UI/helpers/movie_creation_helper.rb'

require_relative './movie/movie_description.rb'
require_relative './movie/movie_ratings.rb'
require_relative './movie/movie_genre.rb'
require_relative './movie/movie_crew.rb'
require_relative './movie/movie_info.rb'
require_relative './movie/movie.rb'

require_relative './cinema_repertoire.rb'
require_relative './cinema_screen.rb'
require_relative './cinema.rb'

require_relative './session/cinema_object_collection_helper.rb'
require_relative './session/session_manager.rb'
require_relative './session/file_storage.rb'

require 'time'

UI = ConsoleUserInterface.new
main_menu = [
  'List movies',
  'List screenings',
  'Add movie',
  'Add screening',
  'Exit program'
]
@cinema = Cinema.new
@session_manager = SessionManager.new(FileStorage.new('../data/test.json'))

def process_exit
  UI.send_message 'Do you want to save your current session?(Y/N)'
  process_save_session if UI.receive_yes_no
  exit
end

def process_save_session
  collector = CinemaObjectCollectionHelper.new(@cinema)
  @session_manager.save_session(collector.collect_all)
end

def process_restore_session
  deserialized_objects = @session_manager.restore_session
  @cinema.repertoire.add_movies(movies: deserialized_objects['Movie'])
end

# program start
on = true

# loading previous session
UI.send_message 'Do you want to restore previous session?(Y/N)'
process_restore_session if UI.receive_yes_no

while on
  UI.list(main_menu)
  input = UI.receive_input
  case input
  when '1'
    UI.list(@cinema.repertoire.movies)
  when '2'
    UI.list(@cinema.repertoire.movie_screenings)
  when '3'
    @cinema.repertoire.add_movie(movie: create_movie)
  when '4'
    puts 'lol'
  when '5'
    process_exit
  end
end
