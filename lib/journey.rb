class Journey
  MINIMUM_FARE = 1
  PENALTY = 6
  attr_reader :entry_station, :exit_station

  def set_the_entry(entry_station)
    @entry_station = entry_station
  end

  def set_the_exit(exit_station)
    @exit_station = exit_station
  end

  def completed
    !@entry_station.nil? && !@exit_station.nil?
  end

  def fare
    completed == true ? MINIMUM_FARE + (@entry_station.zone - @exit_station.zone).abs : PENALTY
  end

  def journey_hash
    { entry: @entry_station, exit: @exit_station }
  end

end