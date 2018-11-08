class Journey

  attr_reader :entry_station, :exit_station, :penalty

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def touch_in(station)
    @entry_station = station
  end

  def touch_out(station)
    @exit_station = station
  end

  def report
    { entry_station: @entry_station, exit_station: @exit_station }
  end

  def fare
    return 6 if penalty?

    return 1 if completed?

    raise "Journey incomplete"
  end

  def live?
    !@entry_station.nil? && @exit_station.nil?
  end

  def penalty?
    penalty
  end

  def completed?
    @exit_station != nil
  end

  def penalise_journey
    @penalty = true
  end

end
