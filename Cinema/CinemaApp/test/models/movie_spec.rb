# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  before(:each) do
    cinema = Cinema.create
    repertoire = Repertoire.create(cinema_id: cinema.id)
    @movie = Movie.create
    RepertoireMovie.create(repertoire_id: repertoire.id, movie_id: @movie.id)
    Description.create(
      title: 'Title',
      summary: 'summary',
      genre_id: Genre.create(name: 'ACTION').id,
      movie_id: @movie.id
    )
    Info.create(
      duration: 1000,
      release_date: Time.at(1_531_411_120),
      rating_id: Rating.create(name: 'PG').id,
      movie_id: @movie.id
    )
    Crew.create(info_id: @movie.info.id)
  end

  it 'get title' do
    expect(@movie.title).to eq 'Title'
  end

  it 'get genre' do
    expect(@movie.genre).to eq 'ACTION'
  end

  it 'get duration' do
    expect(@movie.duration).to eq 1000
  end

  it 'should stringify' do
    expect(@movie.to_s)
      .to eq "\nTitle (2018)\nPG | 00h 16min | ACTION | 2018-07-12\nsummary"
  end
end
