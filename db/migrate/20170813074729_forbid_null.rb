class ForbidNull < ActiveRecord::Migration[5.1]
  def change
    # games
    change_column_default :games, :status, 0
    change_column_null :games, :status, false
    change_column_null :games, :deck_count, false
    change_column_null :games, :player_count, false

    # players
    change_column_null :players, :game_id, false
    change_column_default :players, :status, 0
    change_column_null :players, :status, false
    change_column_null :players, :is_dealer, false

    # deal_histories
    change_column_null :deal_histories, :player_id, false
    change_column_null :deal_histories, :card, false
  end
end
