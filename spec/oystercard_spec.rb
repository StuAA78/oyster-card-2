require 'oystercard'

describe Oystercard do
  it 'has a balance of zero' do
    expect(subject.balance).to eq (0)
  end

  describe '#top_up' do
    it 'can top up the balance' do
      expect { subject.top_up 1 }.to change { subject.balance }.by 1
    end
  end
end
