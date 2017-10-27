require_relative '../src/cinema_screen.rb'

RSpec.describe ':Cinema Screen:' do
  before(:each) do
    @cinema_screen = CinemaScreen.new(name: 'test', seat_count: 40)
  end

  it 'should get cinema screen name' do
    expect(@cinema_screen.name).to eq('test')
  end

  it 'should get cinema screen seat count' do
    expect(@cinema_screen.seat_count).to eq(40)
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
