# This is an oystercard class
class Oystercard
  attr_reader :balance, :entry_station
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  def initialize
    self.balance = 0
  end

  def top_up(amount)
    raise "Max balance of #{MAXIMUM_BALANCE} exceeded" \
      if go_over_max?(amount)
    self.balance += amount
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    raise "Already touched in" if in_journey?
    raise "Balance is lower than #{MINIMUM_BALANCE}" \
      if balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out
    raise "Not touched in" unless in_journey?
    deduct(MINIMUM_CHARGE)
    @entry_station = nil
  end

  private

  attr_writer :balance

  def go_over_max?(amount)
    amount + balance > MAXIMUM_BALANCE
  end

  def deduct(amount)
    self.balance -= amount
  end
end
