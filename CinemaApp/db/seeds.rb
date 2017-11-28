# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)

RATINGS = {
  G: Rating.create!(name: 'G'),
  PG: Rating.create!(name: 'PG'),
  PG13: Rating.create!(name: 'PG13'),
  PG17: Rating.create!(name: 'PG17'),
  R: Rating.create!(name: 'R')
}.freeze

GENRES = {
  ACTION: Genre.create!(name: 'ACTION'),
  ADVENTURE: Genre.create!(name: 'ADVENTURE'),
  ANIMATION: Genre.create!(name: 'ANIMATION'),
  COMEDY: Genre.create!(name: 'COMEDY'),
  CRIME: Genre.create!(name: 'CRIME'),
  DRAMA: Genre.create!(name: 'DRAMA'),
  FANTASY: Genre.create!(name: 'FANTASY'),
  HISTORICAL: Genre.create!(name: 'HISTORICAL'),
  HORROR: Genre.create!(name: 'HORROR'),
  MYSTERY: Genre.create!(name: 'MYSTERY'),
  MUSICAL: Genre.create!(name: 'MUSICAL'),
  ROMANCE: Genre.create!(name: 'ROMANCE'),
  SCIFI: Genre.create!(name: 'SCIFI'),
  THRILLER: Genre.create!(name: 'THRILLER'),
  WAR: Genre.create!(name: 'WAR'),
  WESTERN: Genre.create!(name: 'WESTERN')
}.freeze

cinema = Cinema.create

3.times do |i|
  Screen.create!(title: "Seed screen #{i}", seat_count: 20, cinema: cinema)
end

repertoire = Repertoire.create!(cinema: cinema)

inception = Movie.create
se7en = Movie.create

RepertoireMovie.create!(
  repertoire: repertoire,
  movie: inception
)

RepertoireMovie.create!(
  repertoire: repertoire,
  movie: se7en
)

Description.create!(
  title: 'Inception',
  summary: "Dom Cobb (Leonardo DiCaprio) is a thief with the rare ability to enter people's dreams and steal their secrets from their subconscious. His skill has made him a hot commodity in the world of corporate espionage but has also cost him everything he loves. Cobb gets a chance at redemption when he is offered a seemingly impossible task: Plant an idea in someone's mind. If he succeeds, it will be the perfect crime, but a dangerous enemy anticipates Cobb's every move.",
  genre: GENRES[:SCIFI],
  movie: inception
)

Description.create!(
  title: 'Se7en',
  summary: "When retiring police Detective William Somerset (Morgan Freeman) tackles a final case with the aid of newly transferred David Mills (Brad Pitt), they discover a number of elaborate and grizzly murders. They soon realize they are dealing with a serial killer (Kevin Spacey) who is targeting people he thinks represent one of the seven deadly sins. Somerset also befriends Mills' wife, Tracy (Gwyneth Paltrow), who is pregnant and afraid to raise her child in the crime-riddled city.",
  genre: GENRES[:MYSTERY],
  movie: se7en
)

inception_info = Info.create!(
  duration: 8800,
  release_date: '2010-09-18',
  rating: RATINGS[:PG13],
  movie: inception
)

se7en_info = Info.create!(
  duration: 7620,
  release_date: '1995-05-22',
  rating: RATINGS[:R],
  movie: se7en
)

inception_crew = Crew.create!(
  info: inception_info
)

se7en_crew = Crew.create!(
  info: se7en_info
)

# Inception Crew
Director.create!(
  name: 'Christopher',
  surname: 'Nolan',
  crew: inception_crew
)

Writer.create!(
  name: 'Christopher',
  surname: 'Nolan',
  crew: inception_crew
)

Actor.create!(
  name: 'Leonardo',
  surname: 'DiCaprio',
  crew: inception_crew
)
Actor.create!(
  name: 'Joseph',
  surname: 'Gordon-Levitt',
  crew: inception_crew
)
Actor.create!(
  name: 'Ellen',
  surname: 'Page',
  crew: inception_crew
)

# Se7en Crew
Director.create!(
  name: 'David',
  surname: 'Fincher',
  crew: se7en_crew
)

Writer.create!(
  name: 'Andrew Kevin',
  surname: 'Walker',
  crew: se7en_crew
)

Actor.create!(
  name: 'Morgan',
  surname: 'Freeman',
  crew: se7en_crew
)
Actor.create!(
  name: 'Brad',
  surname: 'Pitt',
  crew: se7en_crew
)
Actor.create!(
  name: 'Kevin',
  surname: 'Spacey',
  crew: se7en_crew
)

Screening.create!(
  time: Time.now,
  screen: cinema.screens.first,
  movie: inception
)
