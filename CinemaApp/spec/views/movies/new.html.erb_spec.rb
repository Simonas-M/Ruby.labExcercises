# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'movies/new', type: :view do
  before(:each) do
    assign(:movie, Movie.new)
  end

  it 'renders new movie form' do
    render

    expect(rendered).to have_selector('form[action="/movies"][method="post"]')
  end
end
