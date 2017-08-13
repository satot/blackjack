module V1
  class GamesController < ApplicationController
    before_action :set_game, only: [:show, :deal, :winner, :finish]

    # POST /v1/games
    def create
      @game = Game.new(game_params)

      if @game.save
        render json: json_format_show, status: :created
      else
        render json: @game.errors, status: :unprocessable_entity
      end
    end

    # GET /v1/games/:id
    def show
      if @game.active?
        render json: json_format_show
      else
        render json: json_format_inactive, status: :gone
      end
    end

    # POST /v1/games/:id/deal
    def deal
      if @game.active?
        Deal.new(@game, deal_params).handle
        render json: json_format_deal
      else
        render json: json_format_inactive, status: :gone
      end
    end

    # GET /v1/games/:id/winner
    def winner
      if @game.active?
        render json: json_format_winner
      else
        render json: json_format_inactive, status: :gone
      end
    end

    # PUT /v1/games/:id/finish
    def finish
      if @game.active?
        @game.finish!
        render json: json_format_show
      else
        render json: json_format_inactive, status: :gone
      end
    end

    private
    def game_params
      params.require(:games).permit(:player_count, :deck_count)
    end

    def deal_params
      params.require(:game).permit(:player_id, :command)
    end

    def set_game
      @game = Game.find(params[:id])
    end

    # TODO move to view...
    def json_format_show
      {
        id: @game.id,
        status: @game.status,
        players: @game.players.select(&:player?).map(&:as_json),
        dealer: @game.dealer.as_json
      }
    end

    def json_format_deal
      player = @game.player deal_params[:player_id]
      {
        id: @game.id,
        player: player.as_json,
        dealer: @game.dealer.as_json(player.status)
      }
    end

    def json_format_winner
      {
        id: @game.id,
        status: @game.status,
        winner: @game.winner
      }
    end

    def json_format_inactive
      {
        id: @game.id,
        status: @game.status,
        message: "The game has been inactivated."
      }
    end
  end
end
