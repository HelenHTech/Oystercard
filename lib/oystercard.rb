# A card to store funds and pay for travel
class Oystercard
  attr_reader :balance, :journey_list
  MAX_BALANCE = 9000
  MIN_BALANCE = Journey::MINIMUM_FARE
  MAX_ERROR = "Cannot top-up beyond £#{MAX_BALANCE / 100}".freeze
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
    !@current_journey.nil?
  end

  def touch_in(station)
    raise MIN_ERROR unless min_balance_met?

    @current_journey = Journey.new
    @current_journey.start(station)
  end

  def touch_out(exit_station)
    @current_journey.finish(exit_station)
    @journey_list.push(@current_journey.journey_hash)
    charge
  end

  def min_balance_met?
    @balance >= MIN_BALANCE
  end

  private

  def charge
    @balance -= @current_journey.fare
    @current_journey = nil
  end
end
