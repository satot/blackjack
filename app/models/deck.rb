class Deck
  MINIMUN_DECK_COUNT = 1
  attr_accessor :cards
  attr_reader :num

  def initialize num
    @num = [num.to_i, MINIMUN_DECK_COUNT].max
    @cards = build_cards
  end

  def remove card
    target = cards.select do |c|
      c.suit == card.suit and c.number == card.number
    end.first
    cards.delete target
  end

  private
  def build_cards
    cards = []
    num.times do
      [:club, :diamond, :spade, :heart].each do |suit|
        (2..10).each{|number| cards << Card.new(suit, number)}
        [:J, :Q, :K, :A].each{|facecard| cards << Card.new(suit, facecard)}
      end
    end
    cards.shuffle
  end
end
