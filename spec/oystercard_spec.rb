require 'oystercard'

describe Oystercard do
  max_balance = Oystercard::MAXIMUM_BALANCE
  min_balance = Oystercard::MINIMUM_BALANCE
  min_charge = Oystercard::MINIMUM_CHARGE

  it 'has a balance of zero' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'can top up the balance' do
      expect { subject.top_up 1 }.to change { subject.balance }.by 1
    end

    it 'raises an error if the maximum balance is exceeded' do
      subject.top_up(max_balance)
      error = "Max balance of #{max_balance} exceeded"
      expect { subject.top_up(1) }.to raise_error error
    end
  end

  it 'is initially not in a journey' do
    expect(subject).not_to be_in_journey
  end

  describe '#touch_in' do
    it 'can touch in' do
      subject.top_up min_balance
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'raises an error when the balance is below the minimum' do
      error = "Balance is lower than #{min_balance}"
      expect { subject.touch_in }.to raise_error error
    end
  end

  describe '#touch_out' do
    it 'can touch out' do
      subject.top_up min_balance
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it 'deducts the minimum charge when touching out' do
      subject.top_up max_balance
      subject.touch_in
      expect { subject.touch_out }.to change { subject.balance }.by -min_charge
    end
  end
end
