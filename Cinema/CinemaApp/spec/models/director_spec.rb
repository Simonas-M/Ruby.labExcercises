# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Director, type: :model do
  fixtures :directors
  before :each do
    @director = directors(:inception_director)
  end
  it 'should get the name' do
    expect(@director.name).to eq 'Christopher'
  end

  it 'should get the surname' do
    expect(@director.surname).to eq 'Nolan'
  end
end
