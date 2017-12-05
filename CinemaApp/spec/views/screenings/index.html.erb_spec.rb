# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'screenings/index', type: :view do
  fixtures :all
  before(:each) do
    assign(:screenings, [
             screenings(:inception_screening),
             screenings(:se7en_screening)
           ])
  end

  it 'renders a list of screenings' do
    render
    expect(rendered).to include 'Se7en'
    expect(rendered).to include 'Inception'
  end
end
