# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cinema, type: :model do
  before(:each) do
    @cinema = Cinema.create
  end

  it 'should add screen' do
    screen = { title: 'test', seat_count: 20 }
    @cinema.add_screen(screen)
    expect(Screen.exists?(screen)).to be true
  end

  it 'should add screens' do
    screens = [
      { title: 'test', seat_count: 20 },
      { title: 'test2', seat_count: 50 }
    ]
    @cinema.add_screens(screens)
    expect(Screen.exists?(screens[0])).to be true
    expect(Screen.exists?(screens[1])).to be true
  end
end
