require 'journey_log'
require 'journey'
require 'oystercard'

describe Journeylog do
let(:station) { double(:station) }
let(:journey) { double(:journey) }
let(:journey_class){ double(:journey_class)}

context 'Logging a journey' do
  it 'Starting a journey' do
    subject.start(station)
    expect(subject.current_journey.entry_station).to eq(station)
  end
  # it 'Finish station' do
  #   subject.finish(station)
  #   expect(subject.exit_station).to eq(station)
  # end
end

it 'Records journey' do
  subject.start(station)
  expect(subject.journeys).to include(station)
end

end