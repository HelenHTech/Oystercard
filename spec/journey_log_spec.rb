require 'journey_log'
describe JourneyLog do

  let(:station){ double :station }
  let(:journeylog)     { JourneyLog.new }

  it { should respond_to(:start).with(1).argument }

  describe '#start' do
    it 'starts a journey' do
      journeylog.start(station)
      journey = journeylog.journeys[0]
      expect(journey.entry_station).to eq(station)
    end

    it 'records a journey' do
      journeylog.start(station)
      journey = journeylog.journeys[0]
      expect(journey.entry_station).to eq(station)
    end
  end
end