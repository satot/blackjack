class DealHistory < ApplicationRecord
  belongs_to :player

  def to_card
    num, suit = self.card.split("-")
    num = num.to_i.zero? ? num.to_sym : num.to_i
    Card.new(suit.to_sym, num)
  end
end
