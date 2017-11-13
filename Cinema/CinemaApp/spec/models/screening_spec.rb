require_relative '../custom_matchers/screening_matchers.rb'
require 'rails_helper'

RSpec.describe Screening, type: :model do
  include ScreeningMatchers
  fixtures :all
  before(:each) do
    @movie_screening = screenings(:se7en_screening)
  end

  it 'should convert time to utc' do
    expect(@movie_screening.time.utc?).to eq true
  end

  it 'should reserve seats' do
    @movie_screening.reserve(5)
    expect(@movie_screening).to have_reserved_seats(5)
  end

  it 'should decrease and increase available seat count' do
    @movie_screening.reserve('3')
    expect(@movie_screening.available_seat_count).to eq(37)
    expect { @movie_screening.free('2') }
      .to change { @movie_screening.available_seat_count }.from(37).to(39)
  end

  it'should increase available seat count' do
    @movie_screening.reserve('40')
    @movie_screening.free('40')
    expect(@movie_screening.available_seat_count).to eq(40)
  end

  it 'should raise when reserving more seats then available' do
    @movie_screening.reserve('38')
    expect { @movie_screening.reserve('3') }
      .to raise_error('not enough free seats available')
  end

  it 'should raise when freeing more seats then reserved' do
    @movie_screening.reserve('5')
    expect { @movie_screening.free('6') }.to raise_error('cannon free 6 seats')
  end

  it 'should return false if not enough seats are available' do
    expect(@movie_screening.available?(50)).to be false
  end

  it 'should return true if there are enough seats are available' do
    expect(@movie_screening.available?(3)).to be true
    expect(@movie_screening.available?(40)).to be true
  end

  it 'should stringify' do
    expect(@movie_screening.to_s)
      .to eq "\nSe7en\nR | Screen one\n2017-10-01 18h 00min"
  end
end
