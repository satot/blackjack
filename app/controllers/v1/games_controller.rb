module V1
  class GamesController < ApplicationController
    def index
      render json: Game.all
    end

    # POST /v1/games
    def create
      @game = Game.new(game_params)

      if @game.save
        render json: {id: @game.id}, status: :created
      else
        render json: @game.errors, status: :unprocessable_entity
      end
    end

    private
    def game_params
      params.require(:games).permit(:player_count, :deck_count)
    end
  end
end
