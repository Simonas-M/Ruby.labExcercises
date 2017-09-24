require_relative '../src/cinema_screen.rb'

describe ':Cinema Screen:' do
  before(:each) do
    @cinema_screen = CinemaScreen.new(name: 'test', seat_count: 40)
  end
  it 'should get cinema screen name' do
    expect(@cinema_screen.name).to eq('test')
  end
  it 'should get cinema screen seat count' do
    expect(@cinema_screen.seat_count).to eq(40)
  end
end
