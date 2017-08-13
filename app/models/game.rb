class Game < ApplicationRecord
  validates :player_count, :deck_count, presence: true
  validates :player_count, numericality: {only_integer: true, greater_than: 0}
  validates :deck_count, numericality: {only_integer: true, greater_than: 0}

  enum status: {
    playing: 0,
    over: 1
  }
end
