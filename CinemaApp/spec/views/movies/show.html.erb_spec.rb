require 'rails_helper'

RSpec.describe "movies/show", type: :view do
  fixtures :all
  before(:each) do
    @movie = assign(:movie, movies(:inception))
  end

  it "renders title in <h1>" do
    render
    expect(rendered).to have_selector('body > div.title_wrapper > h1',
                                      text: 'Inception')
  end

  it 'renders summary in <p>' do
    render
    expect(rendered).to have_selector('div > p', text: %(A thief, who steals co\
rporate secrets through use of dream-sharing technology, is given the inverse t\
ask of planting an idea into the mind of a CEO.))
  end
end
