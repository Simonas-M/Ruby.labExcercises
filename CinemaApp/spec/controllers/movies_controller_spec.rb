# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  fixtures :all

  before :each do
    Movie.create!()
    Movie.create!()
  end

  let(:movie_parameters) do
    {
      title: 'New movie',
      release_date: '2017-12-15',
      duration: '02:24',
      summary: 'a long summary',
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

  let(:only_info_parameters) do
    {
      duration: '02:24',
      rating: Rating.first.id,
      release_date: '2017-12-15'
    }
  end

  let(:only_description_parameters) do
    {
      title: 'New movie',
      summary: 'a long summary',
      genre: Genre.first.id
    }
  end

  describe 'create_movie' do
    it 'should create movie' do
      expect_any_instance_of(Info).to receive(:save).and_call_original
      expect_any_instance_of(Description).to receive(:save).and_call_original
      expect_any_instance_of(Movie).to receive(:save).and_call_original

      post :create, params: movie_parameters

      expect(Info.last.rating).to eq Rating.find(movie_parameters[:rating])
      expect(Description.last.title).to eq movie_parameters[:title]
    end
  end

  describe 'movie_params' do
    it 'should get only info params' do
      get :index, params: movie_parameters
      expect(controller)
        .to receive(:validate_params).with(:duration, :release_date, :rating)
        .and_call_original
      expect(controller.movie_info_params.to_h)
        .to eq({"duration" => 8640,
                "rating" => Rating.first,
                "release_date" => "2017-12-15"})
    end

    it 'should get only description params' do
      get :index, params: movie_parameters
      expect(controller)
        .to receive(:validate_params).with(:title, :summary, :genre)
        .and_call_original
      expect(controller.movie_description_params.to_h)
        .to eq({"title" => 'New movie',
                "summary" => 'a long summary',
                "genre" => Genre.first})
    end
  end

  describe 'GET #index' do
    it 'returns a success response' do
      expect(Movie).to receive(:all)
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      movie = movies(:se7en)
      get :show, params: { id: movie.to_param }
      expect(response).to be_success
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Movie' do
        expect do
          post :create, params: movie_parameters
        end.to change(Movie, :count).by(1)
      end

      it 'redirects to new movie creation page when error occurs creating' do
        allow(controller).to receive(:create_movie).and_return false
        expect(controller).to receive(:respond)
          .with(movies_new_path, 'An error occured, please try again')
        post :create, params: movie_parameters
      end

      it 'redirects to the created movie' do
        expect(controller).to receive(:respond)
          .with(kind_of(Movie), 'Movie was successfully created.')
        post :create, params: movie_parameters
      end
    end

    context 'with invalid params' do
      it 'redirects to new movie creation page' do
        expect(controller).to receive(:respond)
          .with(movies_new_path, 'Please check if all fields are filled')
        post :create, params: invalid_attributes
      end

      it 'redirects to new movie creation page' do
        expect(controller).to receive(:respond)
          .with(movies_new_path, 'Please check if all fields are filled')
        post :create, params: only_description_parameters
      end

      it 'redirects to new movie creation page' do
        expect(controller).to receive(:respond)
          .with(movies_new_path, 'Please check if all fields are filled')
        post :create, params: only_info_parameters
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested movie' do
      movie = movies(:se7en)
      expect do
        delete :destroy, params: { id: movie.to_param }
      end.to change(Movie, :count).by(-1)
    end

    it 'redirects to the movies list' do
      movie = movies(:se7en)
      delete :destroy, params: { id: movie.to_param }
      expect(response).to redirect_to(movies_url)
    end

    it 'redirects to movies index when theres an error deleting' do
      allow_any_instance_of(Movie).to receive(:destroyed?).and_return false
      expect(controller).to receive(:respond)
        .with(movies_path, 'An error occured, movie not deleted')
      movie = movies(:se7en)
      delete :destroy, params: { id: movie.to_param }
    end

    it 'redirects to movies index when theres an error deleting' do
      allow_any_instance_of(Movie).to receive(:destroyed?).and_return true
      expect(controller).to receive(:respond)
        .with(movies_path, 'Movie was successfully destroyed')
      movie = movies(:se7en)
      delete :destroy, params: { id: movie.to_param }
    end
  end
end
