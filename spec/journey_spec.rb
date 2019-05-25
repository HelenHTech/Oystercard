require 'journey'
require 'oystercard'

describe Journey do
  let(:journey) { Journey.new }
  let(:station_1) { double(:station, zone: 3, name: "Wimbledon") }
  let(:station_2) { double(:station, zone: 1, name: "Waterloo") }

  context 'A journey has started' do
    before { journey.set_the_entry(station_1) }
    it 'should store its start station' do
      expect(journey.entry_station).to eq(station_1)
    end
    it 'should store its finish station' do
      journey.set_the_exit(station_2)
      expect(journey.exit_station).to eq(station_2)
    end
  end

  context 'A journey has not been properly started/finished' do
    it 'should charge a penalty if no exit station is given' do
      journey.set_the_entry(station_1)
      expect(journey.fare).to eq(Journey::PENALTY)
    end
    it 'should charge a penalty if no start startion is given' do
      journey.set_the_exit(station_2)
      expect(journey.fare).to eq(Journey::PENALTY)
    end
  end

  context 'A journey has been completed' do
    before do
      journey.set_the_entry(station_1)
      journey.set_the_exit(station_2)
    end
    it 'should show the journey as complete' do
      expect(journey.completed).to eq(true)
    end
    it 'should charge a £2 fare for a journey from zones 3 to 1' do
      expect(journey.fare).to eq(3)
    end
  end
end