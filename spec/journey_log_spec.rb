require 'journey_log'
require 'journey'

describe Journeylog do
  let(:station) { double(:station) }
  let(:journeylog) { Journeylog.new }

context 'Logging a journey' do
  it 'Starting a journey - Entry station' do
    journeylog.start_journey(station)
    start_journey = journeylog.journeys[0]
    expect(start_journey.entry_station).to eq(station)
  end
  it 'Finishing a journey - Exit station' do
    journeylog.finish_journey(station)
    finish_journey = journeylog.journeys[0]
    expect(finish_journey.exit_station).to eq(station)
  end
end

  # it 'Current_journey method to return only incomplete journey' do
  #   journeylog.start(station)
  #   expect(journeylog.current_journey).to eq(journeylog.journeys[0])
  # end

end