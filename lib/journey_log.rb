require 'journey'

class Journeylog
  attr_reader :journeys
  def initialize(journey = Journey.new)
    @journeys = [journey]
  end

  def start_journey(station)
    @journeys[0].start(station)
  end

  def finish_journey(station)
    @journeys[0].finish(station)
  end

  private
  def current_journey
    if @journeys[0].complete?
      @journeys.push(journey)
    else
      return @journeys
    end
  end

end