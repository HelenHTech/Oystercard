require 'station'

describe Station do
  let(:station) { Station.new(name, zone) }
  let(:name) { 'Farringdon' }
  let(:zone) { 'Zone 1' }

  it 'should tell us its station name' do
    expect(station.name).to eq(name)
  end
  it 'should tell us its station zone' do
    expect(station.zone).to eq(zone)
  end
end
