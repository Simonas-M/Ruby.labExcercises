require_relative '../src/cinema_screen.rb'

describe ':Cinema Screen:' do 
  before(:each) do
    @movie_screen = CinemaScreen.new(id: 1, name: 'test', seat_count: 40)
  end
  it 'should get cinema screen id' do
    expect(@movie_screen.id).to eq(1)
  end
  it 'should get cinema screen name' do
    expect(@movie_screen.name).to eq('test')
  end
  it 'should get cinema screen seat count' do
    expect(@movie_screen.seat_count).to eq(40)
  end
  it 'should get cinema screen available seat count' do
    expect(@movie_screen.available_seat_count).to eq(40)
  end
  it 'should decrease available seat count' do
    @movie_screen.reserve(1)
    expect(@movie_screen.available_seat_count).to eq(39)
  end
  it'should increase available seat count' do
    @movie_screen.reserve(4)
    @movie_screen.free(3)
    expect(@movie_screen.available_seat_count).to eq(39)
  end
  it 'should raise when reserving more seats then available' do
    @movie_screen.reserve(38)
    expect { @movie_screen.reserve(3) }
      .to raise_error('not enough free seats available')
  end
  it 'should raise when freeing more seats then reserved' do
    @movie_screen.reserve(5)
    expect { @movie_screen.free(6) }.to raise_error('max seats to free:5')
  end
end
