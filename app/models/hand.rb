class Hand
  SCORE_BLACKJACK = 21
  SCORE_DEALER_MIN = 17
  attr_reader :cards

  def initialize cards = []
    @cards = cards
  end

  def hit! deck
    @cards << deck.cards.shift
  end

  def value
    score = cards.reduce(0){|sum, card| sum += card.value}
    if num_of_ace > 0 and score > SCORE_BLACKJACK
      for i in 1..num_of_ace do
        score = score - 10 # :A can be 1 or 11
        break if score <= SCORE_BLACKJACK
      end
    end
    score
  end

  def blackjack?
    value == SCORE_BLACKJACK
  end

  def bust?
    value > SCORE_BLACKJACK
  end

  def stop?
    value >= SCORE_DEALER_MIN
  end

  private
  def num_of_ace
    cards.select{|c| c.number == :A}.count
  end
end

