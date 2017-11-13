# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

RATINGS = {
  G: Rating.create(name: 'G'),
  PG: Rating.create(name: 'PG'),
  PG13: Rating.create(name: 'PG13'),
  PG17: Rating.create(name: 'PG17'),
  R: Rating.create(name: 'R')
}.freeze

GENRES = {
  ACTION: Genre.create(name: 'ACTION'),
  ADVENTURE: Genre.create(name: 'ADVENTURE'),
  ANIMATION: Genre.create(name: 'ANIMATION'),
  COMEDY: Genre.create(name: 'COMEDY'),
  CRIME: Genre.create(name: 'CRIME'),
  DRAMA: Genre.create(name: 'DRAMA'),
  FANTASY: Genre.create(name: 'FANTASY'),
  HISTORICAL: Genre.create(name: 'HISTORICAL'),
  HORROR: Genre.create(name: 'HORROR'),
  MYSTERY: Genre.create(name: 'MYSTERY'),
  MUSICAL: Genre.create(name: 'MUSICAL'),
  ROMANCE: Genre.create(name: 'ROMANCE'),
  SCIFI: Genre.create(name: 'SCIFI'),
  THRILLER: Genre.create(name: 'THRILLER'),
  WAR: Genre.create(name: 'WAR'),
  WESTERN: Genre.create(name: 'WESTERN')
}.freeze

cinema = Cinema.create

3.times do |i|
  Screen.create(title: "Seed screen #{i}", seat_count: 20, cinema_id: cinema.id)
end

repertoire = Repertoire.create(cinema_id: cinema.id)

inception = Movie.create
se7en = Movie.create

RepertoireMovie.create(
  repertoire_id: repertoire.id,
  movie_id: inception.id
)

RepertoireMovie.create(
  repertoire_id: repertoire.id,
  movie_id: se7en.id
)

Description.create(
  title: 'Inception',
  summary: 'A thief, who steals corporate secrets through use of dream-sharing technology, is given the inverse task of planting an idea into the mind of a CEO.',
  genre_id: GENRES[:SCIFI].id,
  movie_id: inception.id
)

Description.create(
  title: 'Se7en',
  summary: 'Two detectives, a rookie and a veteran, hunt a serial killer who uses the seven deadly sins as his motives.',
  genre_id: GENRES[:MYSTERY].id,
  movie_id: se7en.id
)

inception_info = Info.create(
  duration: 8800,
  release_date: '2010-09-18',
  rating_id: RATINGS[:PG13].id,
  movie_id: inception.id
)

se7en_info = Info.create(
  duration: 7620,
  release_date: '1995-05-22',
  rating_id: RATINGS[:R].id,
  movie_id: se7en.id
)

inception_crew = Crew.create(
  info_id: inception_info.id
)

se7en_crew = Crew.create(
  info_id: se7en_info.id
)

# Inception Crew
Director.create(
  name: 'Christopher',
  surname: 'Nolan',
  crew_id: inception_crew.id
)

Writer.create(
  name: 'Christopher',
  surname: 'Nolan',
  crew_id: inception_crew.id
)

Actor.create(
  name: 'Leonardo',
  surname: 'DiCaprio',
  crew_id: inception_crew.id
)
Actor.create(
  name: 'Joseph',
  surname: 'Gordon-Levitt',
  crew_id: inception_crew.id
)
Actor.create(
  name: 'Ellen',
  surname: 'Page',
  crew_id: inception_crew.id
)

# Se7en Crew
Director.create(
  name: 'David',
  surname: 'Fincher',
  crew_id: se7en_crew.id
)

Writer.create(
  name: 'Andrew Kevin',
  surname: 'Walker',
  crew_id: se7en_crew.id
)

Actor.create(
  name: 'Morgan',
  surname: 'Freeman',
  crew_id: se7en_crew.id
)
Actor.create(
  name: 'Brad',
  surname: 'Pitt',
  crew_id: se7en_crew.id
)
Actor.create(
  name: 'Kevin',
  surname: 'Spacey',
  crew_id: se7en_crew.id
)

Screening.create(
  time: Time.now,
  screen_id: cinema.screens.first.id,
  movie_id: inception.id
)
