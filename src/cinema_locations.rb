# constants for cinema locations
class CinemaLocations
  @locations = {
    TORONTO: [
      'Screen no.1',
      'Screen no.2',
      'Screen no.3'
    ],
    NEW_YORK: [
      'Screen no.1',
      'Screen no.2',
      'Screen no.3',
      'Screen no.4',
      'Screen no.5'
    ],
    SAN_FRANCISCO: [
      'Screen no.1',
      'Screen no.2',
      'Screen no.3',
      'Screen no.4'
    ]
  }

  def self.location?(location, screen)
    location = location.tr('/ /', '_').upcase.to_sym
    @locations.key?(location) &&
      @locations[location].include?(screen.to_s.capitalize)
  end

  def self.add(location, screens)
    location = location.tr('/ /', '_').upcase.to_sym
    screens.map(&:to_s)
    @locations.merge!(location => screens) unless @locations.key?(location)
  end

  def self.del(location)
    location = location.tr('/ /', '_').upcase.to_sym
    @locations.delete(location) if @locations.key?(location)
  end
end
