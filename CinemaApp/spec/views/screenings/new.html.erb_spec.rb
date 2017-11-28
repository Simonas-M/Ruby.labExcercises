require 'rails_helper'

RSpec.describe "screenings/new", type: :view do
  before(:each) do
    assign(:screening, Screening.new())
  end

  it "renders new screening form" do
    render

    assert_select "form[action=?][method=?]", screenings_path, "post" do
    end
  end
end
