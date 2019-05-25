require 'oystercard'
require 'journey'

describe Oystercard do
  let(:oystercard) { Oystercard.new }
  let(:station) { double(:station_1, zone: 3, name: "Wimbledon") }
  let(:min) { Oystercard::MIN_BALANCE }
  let(:max) { Oystercard::MAX_BALANCE }

  it 'Can be topped up with minimum balance' do
    expect { oystercard.top_up(min) }.to change { oystercard.balance }.by(min)
  end

  it 'should return an Error if maximum balance is exceeded' do
    expect { oystercard.top_up(max + 1) }.to raise_error(Oystercard::MAX_ERROR)
  end

  context 'When topped-up with minimum fare of £1 and journey started' do
    before do
      oystercard.top_up(min)
      oystercard.touch_in(station)
    end
    it 'should deduct a fare from card balance at end of journey' do
      expect { oystercard.touch_out(station) }.to change { oystercard.balance }.by(-min)
    end
  end

  context 'New card with £0 balance' do
    it 'should raise Min Balance error when card is touched in' do
      expect { oystercard.touch_in(station) }.to raise_error(Oystercard::MIN_ERROR)
    end
  end

end