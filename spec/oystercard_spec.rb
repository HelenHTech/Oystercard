require 'oystercard'
require 'journey'

describe Oystercard do
  let (:entry_station_dbl) {double("Entry_station")}
  let (:exit_station_dbl) {double("Exit_station")}
  let(:minimum) {Oystercard::MINIMUM_BALANCE}

  it '#balance == 0' do
    expect(subject.balance).to eq(0)
  end

  it '#top_up(1000)' do
    expect{subject.top_up(1000)}.to change{subject.balance}.by(1000)
  end

  let(:maximum) {Oystercard::MAXIMUM_BALANCE}
  it '#top_up(10000)' do
    expect{subject.top_up(maximum+1)}.to raise_error("Maximum limit (of £#{maximum/100}) reached")
  end

  context '#balance=3000' do
    before {subject.top_up(3000)}
    it '#touch_out' do
      subject.touch_in(entry_station_dbl)
      expect{subject.touch_out(exit_station_dbl)}.to change{subject.balance}.by(-minimum)
    end
    it 'touch_out' do
      subject.touch_in(entry_station_dbl)
      subject.touch_out(exit_station_dbl)
      expect(subject.entry_station).to eq(nil)
    end
    it '#touch_in' do
      subject.touch_in(entry_station_dbl)
      expect(subject.in_journey?).to eq(true)
    end
  end

  it '#in_journey?' do
    subject.top_up(minimum)
    subject.touch_in(entry_station_dbl)
    expect(subject.in_journey?).to eq(true)
  end
  it '#touch_out' do
    subject.top_up(minimum)
    subject.touch_in(entry_station_dbl)
    subject.touch_out(exit_station_dbl)
    expect(subject.in_journey?).to eq(false)
  end

  context '#balance=99' do
    it '#touch_in' do
      expect{subject.touch_in(entry_station_dbl)}.to raise_error("Minimum fare of £#{minimum/100} is required to touch in")
    end
  end

  it 'Store one journey, in hash' do
    subject.top_up(minimum)
    subject.touch_in(entry_station_dbl)
    subject.touch_out(exit_station_dbl)
    expect(subject.list_of_journeys).to eq([{:entry => entry_station_dbl, :exit => exit_station_dbl}])
  end

end