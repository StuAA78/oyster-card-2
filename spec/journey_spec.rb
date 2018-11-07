require 'journey'

describe Journey do

  let(:station) { double('station') }

  describe '#completed?' do

    it 'reports true if journey completed' do
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.completed?).to eq true
    end

    it 'reports false if journey is not compelted' do
      subject.touch_in(station)
      expect(subject.completed?).to eq false
    end

  end

  describe '#fare' do

    it 'returns 1 if called on a completed journey' do
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.fare).to eq 1
    end

    it 'returns 6 if called on a penalty journey' do
      subject.penalise_journey
      expect(subject.fare).to eq 6
    end

  end

end
