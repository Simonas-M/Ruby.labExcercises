# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ScreeningsController, type: :controller do
  fixtures :all

  let(:screening_params) do
    {
      time: Time.now,
      movie_id: Movie.first.id,
      screen_id: Screen.first.id
    }
  end

  let(:invalid_attributes) do
    {
      some: 'useless',
      hash: nil
    }
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      screening = screenings(:se7en_screening)
      get :show, params: { id: screening.to_param }
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
      it 'creates a new Screening' do
        expect(controller)
          .to receive(:validate_params).with(:time, :movie_id, :screen_id)
        expect do
          post :create, params: screening_params
        end.to change(Screening, :count).by(1)
      end

      it 'redirects to the created screening' do
        post :create, params: screening_params
        expect(response).to redirect_to(Screening.last)
      end

      it 'redirects to new screening creation page when repertoire cant add' do
        allow(ScreeningHelper)
          .to receive(:overlaps?).and_return true
        expect(controller).to receive(:respond)
          .with(screenings_new_path, 'cannot add overlaping screening')
        post :create, params: screening_params
      end
    end

    context 'with invalid params' do
      it 'redirects to new screening creation page' do
        post :create, params: invalid_attributes
        expect(response).to redirect_to(screenings_new_url)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested screening' do
      expect(controller).to receive(:respond)
        .with(screenings_url, 'Screening was successfully destroyed')
      expect do
        screening = screenings(:se7en_screening)
        delete :destroy, params: { id: screening.to_param }
      end.to change(Screening, :count).by(-1)
    end

    it 'redirects to screenings index when theres an error deleting' do
      allow_any_instance_of(Screening).to receive(:destroyed?).and_return false
      expect(controller).to receive(:respond)
        .with(screenings_url, 'An error occured, screening not deleted')
      screening = screenings(:se7en_screening)
      delete :destroy, params: { id: screening.to_param }
    end

    it 'redirects to the screenings list' do
      screening = screenings(:se7en_screening)
      delete :destroy, params: { id: screening.to_param }
      expect(response).to redirect_to(screenings_url)
    end
  end
end
