# Stores all journey details
class Journey
  MINIMUM_FARE = 100
  PENALTY = 600
  attr_reader :entry_station, :exit_station

  def start(station)
    @entry_station = station
  end

  def finish(station)
    @exit_station = station
  end

  def completed
    !@entry_station.nil? && !@exit_station.nil?
  end

  def fare
    completed == true ? MINIMUM_FARE : PENALTY
  end

  def journey_hash
    { entry: @entry_station, exit: @exit_station }
  end
end
