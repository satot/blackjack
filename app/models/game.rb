class Game < ApplicationRecord
  has_many :players
  validates :player_count, :deck_count, presence: true
  validates :player_count, numericality: {only_integer: true, greater_than: 0}
  validates :deck_count, numericality: {only_integer: true, greater_than: 0}

  after_save :initialize_game

  enum status: {
    active: 0,
    inactive: 1
  }

  def dealer
    self.players.select(&:dealer?).first
  end

  def player player_id
    Player.where(id: player_id, game_id: self.id).first
  end

  def winner
    players.select(&:win?).map{|p| "Player#{p.id}"}
  end

  def finish!
    update_attribute :status, "inactive"
  end

  private
  def initialize_game
    deck = Deck.new self.deck_count
    self.player_count.times{initialize_player deck}
    initialize_player deck, "dealer"
  end

  def initialize_player deck, is_dealer = "player"
    player = Player.create!(game_id: self.id, is_dealer: is_dealer)
    hand = Hand.new
    2.times{hand.hit! deck}
    hand.cards.each{|c| player.dealt c}
  end
end
