require 'oystercard'

describe Oystercard do
  max_balance = Oystercard::MAXIMUM_BALANCE
  min_balance = Oystercard::MINIMUM_BALANCE
  min_charge = Oystercard::MINIMUM_CHARGE
  let(:station) { double('station') }
  before(:example) do
    @topped_up_card = Oystercard.new
    @topped_up_card.top_up(max_balance)
  end

  context 'new card' do
    it 'has a balance of zero' do
      expect(subject.balance).to eq 0
    end

    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end
  end

  describe '#top_up' do
    it 'can top up the balance' do
      expect { subject.top_up 1 }.to change { subject.balance }.by 1
    end

    it 'raises an error if the maximum balance is exceeded' do
      error = "Max balance of #{max_balance} exceeded"
      expect { @topped_up_card.top_up(1) }.to raise_error error
    end
  end



  describe '#touch_in' do
    it 'can touch in' do
      @topped_up_card.touch_in(station)
      expect(@topped_up_card).to be_in_journey
    end

    it 'raises an error when the balance is below the minimum' do
      error = "Balance is lower than #{min_balance}"
      expect { subject.touch_in(station) }.to raise_error error
    end

    it 'stores the entry station' do
      @topped_up_card.touch_in(station)
      expect(@topped_up_card.entry_station).to eq(station)
    end

  end

  describe '#touch_out' do
    it 'can touch out' do
      @topped_up_card.touch_in(station)
      @topped_up_card.touch_out
      expect(@topped_up_card).not_to be_in_journey
    end

    it 'deducts the minimum charge when touching out' do
      @topped_up_card.touch_in(station)
      expect { @topped_up_card.touch_out }.to \
        change { @topped_up_card.balance }.by -min_charge
    end

  end
end
