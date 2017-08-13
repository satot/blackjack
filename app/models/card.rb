class Card
  attr_reader :suit, :number

  def initialize suit, number
    @suit = suit
    @number = number
  end

  def value
    return 10 if [:J, :Q, :K].include? number
    return 11 if number == :A
    return number
  end

  def to_s
    "#{number.to_s}-#{suit}"
  end
end
