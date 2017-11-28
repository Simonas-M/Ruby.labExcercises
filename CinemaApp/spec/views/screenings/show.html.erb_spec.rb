require 'rails_helper'

RSpec.describe "screenings/show", type: :view do
  before(:each) do
    @screening = assign(:screening, Screening.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
