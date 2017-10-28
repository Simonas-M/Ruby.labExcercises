require_relative '../src/cinema_screen.rb'

RSpec.describe 'CinemaScreen' do
  before(:each) do
    @cinema_screen = CinemaScreen.new(name: 'test', seat_count: 40)
  end

  it 'should get cinema screen name' do
    expect(@cinema_screen.name).to eq('test')
  end

  it 'should get cinema screen seat count' do
    expect(@cinema_screen.seat_count).to eq(40)
  end

  it 'should equal to cinema screen with same name and seat count' do
    same_screen = CinemaScreen.new(name: 'test', seat_count: 40)
    expect(@cinema_screen).to eq(same_screen)
  end

  it 'should not equal to cinema screen with different name and seat count' do
    diff_screen = CinemaScreen.new(name: 'test1', seat_count: 42)
    expect(@cinema_screen).not_to eq(diff_screen)
  end

  it 'should not equal to other with different name and same seat count' do
    diff_screen = CinemaScreen.new(name: 'test1', seat_count: 40)
    expect(@cinema_screen).not_to eq(diff_screen)
  end

  it 'should not equal to other with same name and different seat count' do
    diff_screen = CinemaScreen.new(name: 'test', seat_count: 42)
    expect(@cinema_screen).not_to eq(diff_screen)
  end

  it 'should serialize to json' do
    serialized_hash = JSON.parse(@cinema_screen.to_json)
    expect(serialized_hash['name']).to eq(@cinema_screen.name)
    expect(serialized_hash['seat_count']).to eq(@cinema_screen.seat_count)
  end

  it 'should deserialize hash to object' do
    serialized_hash = {
      name: 'Pink Panther',
      seat_count: 39
    }
    from_hash = CinemaScreen.hash_create(nil, serialized_hash)
    expect(from_hash.name).to eq 'Pink Panther'
    expect(from_hash.seat_count).to eq 39
  end
end
