require_relative 'journey'

# This is an oystercard class
class Oystercard
  attr_reader :balance, :entry_station, :journey_history, :current_journey
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  def current_journey
    @journey_history.last
  end

  def initialize(journey_class: Journey)
    @balance = 0
    @journey_history = []
    @journey_class = journey_class
  end

  def top_up(amount)
    raise "Max balance of #{MAXIMUM_BALANCE} exceeded" \
      if go_over_max?(amount)
    @balance += amount
  end

  def in_journey?
    return false if @journey_history.empty?
    current_journey.live?
  end

  def touch_in(station)
    raise "Already touched in" if in_journey?
    raise "Balance is lower than #{MINIMUM_BALANCE}" \
      if balance < MINIMUM_BALANCE
    @journey_history << @journey_class.new
    current_journey.touch_in(station)
  end

  def touch_out(station)
    raise "Not touched in" unless in_journey?
    deduct(MINIMUM_CHARGE)
    current_journey.touch_out(station)
  end

  private

  attr_writer :balance

  def go_over_max?(amount)
    amount + balance > MAXIMUM_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end
end
