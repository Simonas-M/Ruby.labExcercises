# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Actor, type: :model do
  before :each do
  end
  it 'should get the name' do
    expect(actor.name).to eq 'testName'
  end

  it 'should get the surname' do
    expect(actor.surname).to eq 'testSurname'
  end
end
