require 'oystercard'
require 'journey'

describe Oystercard do
  let(:station) { double('Station') }
  let(:min) { Oystercard::MIN_BALANCE }
  let(:max) { Oystercard::MAX_BALANCE }

  it 'Can be topped up with minimum balance' do
    expect { subject.top_up(min) }.to change { subject.balance }.by(min)
  end

  it 'should return an Error if maximum balance is exceeded' do
    expect { subject.top_up(max + 1) }.to raise_error(Oystercard::MAX_ERROR)
  end

  context 'When topped-up with minimum fare of £1 and journey started' do
    before do
      subject.top_up(min)
      subject.touch_in(station)
    end
    it 'Shows as on-going journey' do
      expect(subject.in_journey?).to eq(true)
    end
    it 'should deduct a fare from card balance at end of journey' do
      expect { subject.touch_out(station) }.to change { subject.balance }.by(-min)
    end
  end

  context 'New card with £0 balance' do
    it 'should raise Min Balance error when card is touched in' do
      expect { subject.touch_in(station) }.to raise_error(Oystercard::MIN_ERROR)
    end
  end

  context 'Given a completed journey' do
    before(:each) do
      subject.top_up(min)
      subject.touch_in(station)
      subject.touch_out(station)
    end
    it 'Journey is marked Completed - Card shows not in journey' do
      expect(subject.in_journey?).to eq(false)
    end
    it 'should store the completed journey on card' do
      expect(subject.journey_list).to eq([{ entry: station, exit: station }])
    end
  end
end
