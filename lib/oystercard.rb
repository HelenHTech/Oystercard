class Oystercard
  attr_reader :balance, :storing_journeys
  MAX_BALANCE = 90
  MIN_BALANCE = Journey::MINIMUM_FARE
  MAX_ERROR = "Cannot top-up beyond £#{MAX_BALANCE}".freeze
  MIN_ERROR = "Minimum fare of £#{MIN_BALANCE} is required to touch in".freeze
  def initialize(journey = Journey.new)
    @balance = 0
    @journey = journey
    @storing_journeys = []
  end

  def top_up(amount)
    raise MAX_ERROR if maxxed_out_limit?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    raise MIN_ERROR unless min_balance_met?
    @storing_journeys << @journey.journey_hash
    @journey = Journey.new
    @journey.set_the_entry(entry_station)
  end

  def touch_out(exit_station)
    @journey.set_the_exit(exit_station)
    charge
    @storing_journeys << @journey.journey_hash

  end

  private
  def min_balance_met?
    @balance >= MIN_BALANCE
  end

  def maxxed_out_limit?(amount)
    (@balance + amount) > MAX_BALANCE
  end

  def charge
    @balance -= @journey.fare
  end
end