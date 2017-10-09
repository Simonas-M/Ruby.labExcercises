# constants for cinema locations
module CinemaLocations
  attr_reader :locations
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
      @locations.fetch(location).include?(screen.to_s)
  end

  def self.add(location, screens)
    location = location.tr('/ /', '_').upcase.to_sym
    @locations.merge!(location => screens.map(&:to_s)) unless @locations.key?(location)
  end

  def self.del(location)
    location = location.tr('/ /', '_').upcase.to_sym
    raise 'no such location' unless @locations.key?(location)
    @locations.delete(location)
  end
end
