require 'oystercard'

describe Oystercard do
  max_balance = Oystercard::MAXIMUM_BALANCE
  min_balance = Oystercard::MINIMUM_BALANCE
  min_charge = Oystercard::MINIMUM_CHARGE
  let(:station) { double('station') }
  let(:station2) { double('station') }
  let(:journey) { double('station') }

  before(:example) do
    subject.top_up(max_balance)
  end

  context 'new card' do
    it 'has a balance of zero' do

      expect(Oystercard.new.balance).to eq 0
    end

    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end
  end

  describe '#top_up' do
    it 'can top up the balance' do
      card = Oystercard.new
      expect { card.top_up 1 }.to change { card.balance }.by 1
    end

    it 'raises an error if the maximum balance is exceeded' do
      error = "Max balance of #{max_balance} exceeded"
      expect { subject.top_up(1) }.to raise_error error
    end
  end

  describe '#touch_in' do
    it 'can touch in' do
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'raises an error when the balance is below the minimum' do
      error = "Balance is lower than #{min_balance}"
      expect { Oystercard.new.touch_in(station) }.to raise_error error
    end

    it 'stores the entry station' do
      subject.touch_in(station)
      expect(subject.current_journey.entry_station).to eq(station)
    end

  end

  describe '#touch_out' do
    it 'can touch out' do
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end

    it 'deducts the minimum charge when touching out' do
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to \
        change { subject.balance }.by -min_charge
    end

  end

  describe 'check journey' do
    it 'display the journey history for the card' do
      subject.touch_in(station)
      subject.touch_out(station2)
      subject.touch_in(station2)
      subject.touch_out(station)
      expect(subject.journey_history.first.report).to eq(
        { entry_station: station, exit_station: station2 }
      )
    end
  end
end
