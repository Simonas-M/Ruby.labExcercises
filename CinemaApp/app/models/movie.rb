# frozen_string_literal: true

# movie model
class Movie < ApplicationRecord
  has_many :screenings, dependent: :destroy
  has_many :repertoire_movies, dependent: :destroy
  has_one :description, dependent: :destroy
  has_one :info, dependent: :destroy

  def title
    description.title
  end

  def genre
    description.genre.name
  end

  def duration
    info.duration
  end
  movies
  def release_date
    info.release_date
  end

  def rating
    info.rating.name
  end

  def summary
    description.summary
  end

  def to_s
    RepresentationHelper.stringify_movie(info, description)
  end
end
