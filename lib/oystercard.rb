class Oystercard
  MAXIMUM_BALANCE = 9000
  MINIMUM_BALANCE = Journey::MINIMUM_FARE
  attr_reader :balance, :entry_station, :list_of_journeys, :exit_station
  def initialize(balance=0)
    @balance = balance
    @entry_station
    @exit_station
    @list_of_journeys = []
    @current_journey
  end

  def top_up(amount)
    if @balance + amount > MAXIMUM_BALANCE
      raise "Maximum limit (of £#{MAXIMUM_BALANCE/100}) reached"
    else 
      @balance += amount
    end
  end
  def in_journey?
    !@current_journey.completed
  end
  def touch_in(station)
    if minimum_balance_met?
      @current_journey = Journey.new
      @current_journey.start(station)
    else
      raise "Minimum fare of £1 is required to touch in"
    end
  end
  def touch_out(exit_station)
    deduct(MINIMUM_BALANCE)
    @current_journey.finish(exit_station)
    @list_of_journeys.push(@current_journey.journey_hash)
  end
  def minimum_balance_met?
    @balance >= MINIMUM_BALANCE
  end
  private
  def deduct(amount)
    @balance -= amount
  end
end