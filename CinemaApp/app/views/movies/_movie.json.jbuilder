# frozen_string_literal: true

json.extract! movie, :id, :created_at, :updated_at
json.url movie_url(movie, format: :json)
