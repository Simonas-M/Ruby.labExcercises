require 'rails_helper'

RSpec.describe "movies/index", type: :view do
  fixtures :all
  before(:each) do
    assign(:movies, [
      movies(:se7en),
      movies(:inception)
    ])
  end

  it "renders a list of movies" do
    render
    expect(rendered).to include 'Se7en'
    expect(rendered).to include 'Inception'
  end
end
