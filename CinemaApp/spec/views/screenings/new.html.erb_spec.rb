# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'screenings/new', type: :view do
  before(:each) do
    assign(:screening, Screening.new)
  end

  it 'renders new screening form' do
    render
    expect(rendered)
      .to have_selector('form[action="/screenings"][method="post"]')
  end
end
