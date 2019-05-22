require 'journey'
require 'oystercard'

class Journeylog
  attr_reader :journey_class, :journeys
  def initialize(journey_class = Journey.new)
    @journey_class = journey_class
    @journeys = []
    @current_journey  #  return a list of all previous journeys without exposing the internal array to external modification
  end

  def start(station)
    @journey_class.entry_station = station
    @journeys.push(journey_class.entry_station)
  end

  # def finish(station)
  #   station #  Added exit station to current journey
  # end

  def current_journey
    @current_journey ||= @journey_class
  end

end