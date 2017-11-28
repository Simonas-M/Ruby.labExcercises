require 'rails_helper'

RSpec.describe "screenings/index", type: :view do
  before(:each) do
    assign(:screenings, [
      Screening.create!(),
      Screening.create!()
    ])
  end

  it "renders a list of screenings" do
    render
  end
end
