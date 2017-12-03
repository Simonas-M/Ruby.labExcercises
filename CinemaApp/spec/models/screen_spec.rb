# frozen_string_literal: true

require_relative '../rails_helper.rb'

RSpec.describe Screen, type: :model do
  before(:each) do
    @cinema_screen = Screen.create(title: 'test', seat_count: 40)
  end

  it 'should get cinema screen name' do
    expect(@cinema_screen.title).to eq('test')
  end

  it 'should get cinema screen seat count' do
    expect(@cinema_screen.seat_count).to eq(40)
  end

  it 'should equal to cinema screen with same name and seat count' do
    same_screen = Screen.create(title: 'test', seat_count: 40)
    expect(@cinema_screen).to eq(same_screen)
  end

  it 'should not equal to cinema screen with different name and seat count' do
    diff_screen = Screen.create(title: 'test1', seat_count: 42)
    expect(@cinema_screen).not_to eq(diff_screen)
  end

  it 'should not equal to other with different name and same seat count' do
    diff_screen = Screen.create(title: 'test1', seat_count: 40)
    expect(@cinema_screen).not_to eq(diff_screen)
  end

  it 'should not equal to other with same name and different seat count' do
    diff_screen = Screen.create(title: 'test', seat_count: 42)
    expect(@cinema_screen).not_to eq(diff_screen)
  end

  it 'should stringify' do
    expect(@cinema_screen.to_s).to eq 'test'
  end
end
