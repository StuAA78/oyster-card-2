class Oystercard
  attr_reader :balance
 
  def initialize
    self.balance = 0
  end

  private
 
  attr_writer :balance

end
