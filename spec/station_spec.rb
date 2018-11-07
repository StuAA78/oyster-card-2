require 'station'

describe Station do

  subject { Station.new("Barbican", 1) }

  it 'has a name' do
    expect(subject.name).to eq "Barbican"
  end

  it 'has a zone' do
    expect(subject.zone).to eq 1
  end

end
