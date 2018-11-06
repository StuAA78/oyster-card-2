class Oystercard
  attr_reader :balance
  MAXIMUM_BALANCE = 90

  def initialize
    self.balance = 0
  end

  def top_up(amount)
    fail "Max balance of #{MAXIMUM_BALANCE} exceeded" \
      if go_over_max?(amount)
    self.balance += amount
  end

  def deduct(amount)
    self.balance -= amount
  end

  private

  attr_writer :balance

  def go_over_max?(amount)
    amount + balance > MAXIMUM_BALANCE
  end

end
