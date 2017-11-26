# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Writer, type: :model do
  fixtures :writers
  before :each do
    @writer = writers(:inception_writer)
  end
  it 'should get the name' do
    expect(@writer.name).to eq 'Christopher'
  end

  it 'should get the surname' do
    expect(@writer.surname).to eq 'Nolan'
  end
end
