require 'oystercard'
require 'journey'

describe Oystercard do
  let(:station) { double('Station') }
  let(:min) { Oystercard::MIN_BALANCE }
  let(:max) { Oystercard::MAX_BALANCE }

  it 'Top up card with minimum balance' do
    expect { subject.top_up(min) }.to change{ subject.balance }.by(min)
  end

  it 'Error if maximum balance is exceeded' do
    expect { subject.top_up(max + 1) }.to raise_error(Oystercard::MAX_ERROR)
  end

  context 'Top-up with minimum fare of £1' do
    before do
      subject.top_up(min)
      subject.touch_in(station)
    end
    it 'Deducted fare from card balance' do
      expect { subject.touch_out(station) }.to change { subject.balance }.by(-min)
    end
    it 'Shows as on-gonig journey' do
      expect(subject.in_journey?).to eq(true)
    end
  end

  context 'New card with £0 balance' do
    it 'Raise error when card is touched in' do
      expect { subject.touch_in(station) }.to raise_error(Oystercard::MIN_ERROR)
    end
  end

  context 'Given a completed journey' do
    before(:each) do
      subject.top_up(min)
      subject.touch_in(station)
      subject.touch_out(station)
    end
    it 'Joruney is marked Completed - Card shows not in journey' do
      expect(subject.in_journey?).to eq(false)
    end
    it 'Completed journey stored on card' do
      expect(subject.journey_list).to eq([{ entry: station, exit: station }])
    end
  end
end
