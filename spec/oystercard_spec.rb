require 'oystercard'

describe Oystercard do
  max_balance = Oystercard::MAXIMUM_BALANCE

  it 'has a balance of zero' do
    expect(subject.balance).to eq (0)
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

  describe '#deduct' do
    it 'deducts an amount from the balance' do
      subject.top_up(max_balance)
      expect { subject.deduct max_balance }.to \
        change { subject.balance }.by -max_balance
    end
  end
end
