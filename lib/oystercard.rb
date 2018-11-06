class Oystercard
  attr_reader :balance
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    self.balance = 0
    self.in_journey = false
  end

  def top_up(amount)
    fail "Max balance of #{MAXIMUM_BALANCE} exceeded" \
      if go_over_max?(amount)
    self.balance += amount
  end

  def deduct(amount)
    self.balance -= amount
  end

  def in_journey?
    in_journey
  end

  def touch_in
    fail "Balance is lower than #{MINIMUM_BALANCE}" \
      if balance < MINIMUM_BALANCE
    self.in_journey = true
  end

  def touch_out
    self.in_journey = false
  end

  private

  attr_writer :balance
  attr_accessor :in_journey

  def go_over_max?(amount)
    amount + balance > MAXIMUM_BALANCE
  end

end
