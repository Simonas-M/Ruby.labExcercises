# frozen_string_literal: true

Rails.application.routes.draw do
  root 'cinema#index'

  get '/movies', to: 'movies#index'
  get '/movies/new', to: 'movies#new'
  get '/movies/:id', to: 'movies#show', as: 'movie'
  post '/movies', to: 'movies#create'
  delete '/movies/:id', to: 'movies#destroy'

  get '/screenings', to: 'screenings#index'
  get '/screenings/new', to: 'screenings#new'
  get '/screenings/:id', to: 'screenings#show', as: 'screening'
  post '/screenings', to: 'screenings#create'
  delete '/screenings/:id', to: 'screenings#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
