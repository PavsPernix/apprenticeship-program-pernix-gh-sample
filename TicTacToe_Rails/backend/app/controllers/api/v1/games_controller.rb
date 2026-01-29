module Api
  module V1
    class GamesController < ApplicationController
      before_action :set_game, only: [:show, :move, :reset]

      # POST /api/v1/games
      def create
        game = GameService.create_game
        render json: game, status: :created
      end

      # GET /api/v1/games/:id
      def show
        render json: @game
      end

      # POST /api/v1/games/:id/move
      def move
        position = move_params[:position].to_i

        GameService.make_move(@game, position)
        render json: @game.reload
      rescue GameService::InvalidMoveError => e
        render json: { error: e.message }, status: :unprocessable_entity
      rescue GameService::GameFinishedError => e
        render json: { error: e.message }, status: :unprocessable_entity
      end

      # POST /api/v1/games/:id/reset
      def reset
        GameService.reset_game(@game)
        render json: @game.reload
      end

      private

      def set_game
        @game = Game.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Game not found' }, status: :not_found
      end

      def move_params
        params.require(:move).permit(:position)
      end
    end
  end
end
