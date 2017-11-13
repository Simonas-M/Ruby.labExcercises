# frozen_string_literal: true

# movie model
class Movie < ApplicationRecord
  has_many :screenings
  has_many :repertoire_movies
  has_one :description
  has_one :info

  def title
    description.title
  end

  def genre
    description.genre.name
  end

  def duration
    info.duration
  end

  def to_s
    RepresentationHelper.stringify_movie(info, description)
  end
end
