# This is an oystercard class
class Oystercard
  attr_reader :balance
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  def initialize
    self.balance = 0
    self.in_journey = false
  end

  def top_up(amount)
    raise "Max balance of #{MAXIMUM_BALANCE} exceeded" \
      if go_over_max?(amount)
    self.balance += amount
  end

  def in_journey?
    in_journey
  end

  def touch_in
    raise "Already touched in" if in_journey?
    raise "Balance is lower than #{MINIMUM_BALANCE}" \
      if balance < MINIMUM_BALANCE
    self.in_journey = true
  end

  def touch_out
    raise "Not touched in" unless in_journey?
    deduct(MINIMUM_CHARGE)
    self.in_journey = false
  end

  private

  attr_writer :balance
  attr_accessor :in_journey

  def go_over_max?(amount)
    amount + balance > MAXIMUM_BALANCE
  end

  def deduct(amount)
    self.balance -= amount
  end
end
