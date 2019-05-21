require 'oystercard'
require 'journey'

describe Oystercard do
  let (:station_dbl) {double("Station")}
  let(:minimum) {Oystercard::MINIMUM_BALANCE}
  let(:maximum) {Oystercard::MAXIMUM_BALANCE}

  it 'Top up card with minimum balance' do
    expect{subject.top_up(minimum)}.to change{subject.balance}.by(minimum)
  end

  it 'Error if maximum balance is exceeded' do
    expect{subject.top_up(maximum+1)}.to raise_error(Oystercard::MAX_ERROR)
  end

  context 'Top-up with minimum fare of £1' do
    before {subject.top_up(minimum)
      subject.touch_in(station_dbl)
    }
    it 'Deducted fare from card balance' do
      expect{subject.touch_out(station_dbl)}.to change{subject.balance}.by(-minimum)
    end
    it 'Shows as on-gonig journey' do
      expect(subject.in_journey?).to eq(true)
    end
  end

  context 'New card with £0 balance' do
    it 'Raise error when card is touched in' do
      expect{subject.touch_in(station_dbl)}.to raise_error(Oystercard::MIN_ERROR)
    end
  end

  context 'Given a completed journey' do
    before(:each) {
      subject.top_up(minimum)
      subject.touch_in(station_dbl)
      subject.touch_out(station_dbl)
    }
    it 'Joruney is marked Completed - Card shows not in journey' do
      expect(subject.in_journey?).to eq(false)
    end
    it 'Completd journey stored on card' do
      expect(subject.list_of_journeys).to eq([{:entry => station_dbl, :exit => station_dbl}])
    end
  end
end