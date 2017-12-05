# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  fixtures :all

  let(:movie_parameters) do
    {
      title: 'New movie',
      release_date: '2017-12-15',
      duration: '02:24',
      summary: 'a long sumamry',
      genre: Genre.first.id,
      rating: Rating.first.id
    }
  end

  let(:invalid_attributes) do
    {
      nonsense: true,
      why: 'i dont know'
    }
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      movie = movies(:se7en)
      get :show, params: { id: movie.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Movie' do
        expect do
          post :create, params: movie_parameters, session: valid_session
        end.to change(Movie, :count).by(1)
      end

      it 'redirects to new movie creation page when error occurs creating' do
        allow(controller).to receive(:create_movie).and_return false
        expect do
          post :create, params: movie_parameters, session: valid_session
        end.to change(Movie, :count).by(0)
        expect(response).to redirect_to(movies_new_url)
      end

      it 'redirects to the created movie' do
        post :create, params: movie_parameters, session: valid_session
        expect(response).to redirect_to(Movie.last)
      end
    end

    context 'with invalid params' do
      it 'redirects to new movie creation page' do
        post :create, params: invalid_attributes, session: valid_session
        expect(response).to redirect_to(movies_new_url)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested movie' do
      movie = movies(:se7en)
      expect do
        delete :destroy, params: { id: movie.to_param }, session: valid_session
      end.to change(Movie, :count).by(-1)
    end

    it 'redirects to the movies list' do
      movie = movies(:se7en)
      delete :destroy, params: { id: movie.to_param }, session: valid_session
      expect(response).to redirect_to(movies_url)
    end

    it 'redirects to movies index when theres an error deleting' do
      allow_any_instance_of(Movie).to receive(:destroyed?).and_return false
      expect(controller).to receive(:respond)
        .with(movies_path, 'An error occured, movie not deleted')
      movie = movies(:se7en)
      delete :destroy, params: { id: movie.to_param }, session: valid_session
    end

    it 'redirects to movies index when theres an error deleting' do
      allow_any_instance_of(Movie).to receive(:destroyed?).and_return true
      expect(controller).to receive(:respond)
        .with(movies_path, 'Movie was successfully destroyed')
      movie = movies(:se7en)
      delete :destroy, params: { id: movie.to_param }, session: valid_session
    end
  end
end
