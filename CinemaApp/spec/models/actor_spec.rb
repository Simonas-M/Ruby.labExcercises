# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Actor, type: :model do
  fixtures :actors
  before :each do
    @actor = actors(:inception_actor1)
  end
  it 'should get the name' do
    expect(@actor.name).to eq 'Leonardo'
  end

  it 'should get the surname' do
    expect(@actor.surname).to eq 'DiCaprio'
  end
end
