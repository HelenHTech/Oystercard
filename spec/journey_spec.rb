require 'journey'
require 'oystercard'

describe Journey do
let (:station_dbl) {double("Station")}

  it 'starting a journey' do
    expect(subject.start(station_dbl)).to eq(station_dbl)
  end
  it '#touch_in(entry_station)' do
    subject.start(station_dbl)
    expect(subject.entry_station).to eq(station_dbl)
  end
  it 'finishing a journey' do
    expect(subject.finish(station_dbl)).to eq(station_dbl)
  end

  context 'Encurring penalty charge' do
    it '#fare - No exit station' do
      subject.start(station_dbl)
      expect(subject.fare).to eq(Journey::PENALTY)
    end
    it '#fare - No entry station' do
      subject.finish(station_dbl)
      expect(subject.fare).to eq(Journey::PENALTY)
    end
  end

  context 'Completed journeys' do
    before { subject.start(station_dbl)
      subject.finish(station_dbl)
    }
    it 'Is the journey complete' do
      expect(subject.completed).to eq(true)
    end
    it '#fare - Fare of £1' do
      expect(subject.fare).to eq(Journey::MINIMUM_FARE)
    end
  end

end