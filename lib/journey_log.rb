require 'journey'

class JourneyLog
  attr_reader :journeys
  def initialize(journey = Journey.new)
    @journeys = [journey]
  end

  def start(station)
    @journeys.last.set_the_entry(station)
  end

  def fare
    @journeys.last.fare
  end

  def finish(station)
    @journeys.last.set_the_exit(station)
  end

  private
  def current_journey
    @journeys.last.completed ? @journeys.push(journey) : @journeys[0]
  end

end