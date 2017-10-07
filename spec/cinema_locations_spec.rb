require_relative '../src/cinema_locations.rb'

RSpec.describe '::Cinema Locations' do
  it 'should add new cinema location' do
    CinemaLocations.add('Vilnius', %w[1 2 3])
    expect(CinemaLocations.location?('vilnius', 1)).to be true
    expect(CinemaLocations.location?('vilnius', 2)).to be true
    expect(CinemaLocations.location?('vilnius', 3)).to be true
  end
  it 'should not add same location multiple times' do
    CinemaLocations.add('Vilnius', %w[1 2 3])
    CinemaLocations.add('Vilnius', %w[1 2 3 4 5 6])
    expect(CinemaLocations.location?('vilnius', 6)).to be false
  end
  it 'should delete location' do
    CinemaLocations.add('Vilnius', %w[1 2 3])
    CinemaLocations.del('Vilnius')
    expect(CinemaLocations.location?('vilnius', 1)).to be false
  end
end
