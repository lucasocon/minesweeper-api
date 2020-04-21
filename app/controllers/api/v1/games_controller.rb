# frozen_string_literal: true

module Api
  module V1
    # Games controller
    class GamesController < ApplicationController
      before_action :set_game, only: %i[update]

      def create
        game = Game.new

        if game.save
          render json: game, status: :ok
        else
          render json: { error: true, message: game.errors },
                 status: 500
        end
      end

      def update
        if @game.lost?
          render json: { message: 'Sorry, the game is over, please try again.',
                         game: @game },
                 status: :ok
        else
          result = GameService.new(@game).play_turn(game_params[:x], game_params[:y])

          render json: { message: result, game: @game }, status: :ok
        end
      end

      private

      def set_game
        @game = Game.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: true, message: 'Game Not Found' },
               status: :not_found
      end

      def game_params
        params.require(:game).permit(:x, :y)
      end
    end
  end
end
