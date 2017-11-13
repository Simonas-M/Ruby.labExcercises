# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  fixtures :all
  before(:each) do
    @movie = movies(:inception)
  end

  it 'get title' do
    expect(@movie.title).to eq 'Inception'
  end

  it 'get genre' do
    expect(@movie.genre).to eq 'SCIFI'
  end

  it 'get duration' do
    expect(@movie.duration).to eq 8800
  end

  it 'should stringify' do
    expect(@movie.to_s)
      .to eq %(\nInception (2010)\nPG13 | 02h 26min | SCIFI | 2010-09-18
A thief, who steals corporate secrets through use of dream-sharing technology, \
is given the inverse task of planting an idea into the mind of a CEO.)
  end
end
