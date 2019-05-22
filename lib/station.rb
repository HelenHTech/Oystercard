# Stores name/zone of stations in the Oystercard network
class Station
  attr_reader :name, :zone
  def initialize(name, zone)
    @name = name
    @zone = zone
  end
end
