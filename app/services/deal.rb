class Deal
  attr_accessor :game, :player, :deck, :command
  ACTIONS = %w(hit stand)

  def initialize game, params
    @game = game
    @player = @game.player params[:player_id]
    @command = params[:command]
    @deck = prepare_deck
  end

  def handle
    return unless player.playing?
    unless ACTIONS.include? @command
      @command = "hit"
    end
    case @command
    when "hit"
      handle_hit
    when "stand"
      handle_stand
    end
  end

  private
  def prepare_deck
    deck = Deck.new(game.deck_count)
    game.players.each do |player|
      player.deal_histories.map(&:to_card).each{|card| deck.remove card}
    end
    deck
  end

  def handle_hit
    player.hit deck
    if player.hand.bust? or player.hand.blackjack?
      confirm_status
    end
  end

  def handle_stand
    confirm_status
  end

  def confirm_status
    case winner
    when :dealer then player.lose!
    when :player then player.win!
    else player.push!
    end
  end

  def dealer_hand
    dealer = game.dealer
    unless dealer.confirmed?
      while !dealer.hand.bust? and !dealer.hand.stop? do
        dealer.hit deck
      end
      dealer.confirmed!
    end
    dealer.hand
  end

  def winner
    p_hand = player.hand
    d_hand = dealer_hand # to confirm dealer's score in advance
    if p_hand.bust? or (!d_hand.bust? and d_hand.value > p_hand.value)
      :dealer
    elsif dealer_hand.value == p_hand.value
      nil
    else
      :player
    end
  end
end
