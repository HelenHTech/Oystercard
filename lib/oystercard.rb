# A card to store funds and pay for travel
class Oystercard
  attr_reader :balance, :entry_station, :journey_list, :exit_station
  MAX_BALANCE = 9000
  MIN_BALANCE = Journey::MINIMUM_FARE
  MAX_ERROR = "Maximum limit (of £#{MAX_BALANCE / 100}) reached".freeze
  MIN_ERROR = "Minimum fare of £#{MIN_BALANCE / 100} is required to touch in".freeze
  def initialize(balance = 0)
    @balance = balance
    @journey_list = []
    @current_journey = nil
  end

  def top_up(amount)
    raise MAX_ERROR if @balance + amount > MAX_BALANCE

    @balance += amount
  end

  def in_journey?
    !@current_journey.completed
  end

  def touch_in(station)
    raise MIN_ERROR unless min_balance_met?

    @current_journey = Journey.new
    @current_journey.start(station)
  end

  def touch_out(exit_station)
    deduct(MIN_BALANCE)
    @current_journey.finish(exit_station)
    @journey_list.push(@current_journey.journey_hash)
  end

  def min_balance_met?
    @balance >= MIN_BALANCE
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
