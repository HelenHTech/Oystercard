require 'journey'
require 'oystercard'

describe Journey do
  let(:station) { double('Station') }

  context 'A journey has started' do
    before { subject.start(station) }
    it 'should store its start station' do
      expect(subject.entry_station).to eq(station)
    end
    it 'should store its finish station' do
      subject.finish(station)
      expect(subject.exit_station).to eq(station)
    end
  end

  context 'A journey has not been properly started/finished' do
    it 'should charge a penalty if no exit station is given' do
      subject.start(station)
      expect(subject.fare).to eq(Journey::PENALTY)
    end
    it 'should charge a penalty if no start startion is given' do
      subject.finish(station)
      expect(subject.fare).to eq(Journey::PENALTY)
    end
  end

  context 'A journey has been completed' do
    before do
      subject.start(station)
      subject.finish(station)
    end
    it 'should shoew the journey as complete' do
      expect(subject.completed).to eq(true)
    end
    it 'should charge the minimum fare' do
      expect(subject.fare).to eq(Journey::MINIMUM_FARE)
    end
  end
end
