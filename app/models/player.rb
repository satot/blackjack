class Player < ApplicationRecord
  belongs_to :game
  has_many :deal_histories
  attr_accessor :hand

  enum status: {
    playing: 0,
    win: 1,
    lose: 2,
    push: 3,
    confirmed: 4
  }

  enum is_dealer: {
    player: false,
    dealer: true
  }

  def dealt card
    DealHistory.create!(player_id: self.id, card: card.to_s)
  end

  def hand
    @hand ||= Hand.new self.deal_histories.map(&:to_card)
  end

  def hit deck
    hand.hit! deck
    dealt hand.cards.last
  end

  def win!
    update_attribute :status, "win"
  end

  def lose!
    update_attribute :status, "lose"
  end

  def push!
    update_attribute :status, "push"
  end

  def confirmed!
    update_attribute :status, "confirmed"
  end

  def as_json player_status = "playing"
    if self.dealer?
      if player_status == "playing"
        score = "-"
        hand = [self.hand.cards.first.to_s, "X-X"]
      else
        score = self.hand.value
        hand = self.hand.cards.map(&:to_s)
      end
      {
        "name": "Dealer",
        "status": self.status,
        "score": score,
        "hand": hand
      }
    else
      {
        "name": "Player#{self.id}",
        "status": self.status,
        "score": self.hand.value,
        "hand": self.hand.cards.map(&:to_s)
      }
    end
  end
end
