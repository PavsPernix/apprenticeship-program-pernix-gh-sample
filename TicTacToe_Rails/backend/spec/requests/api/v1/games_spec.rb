require 'rails_helper'

RSpec.describe 'Api::V1::Games', type: :request do
  describe 'POST /api/v1/games' do
    it 'creates a new game' do
      post '/api/v1/games'

      expect(response).to have_http_status(:created)

      json = JSON.parse(response.body)
      expect(json['id']).to be_present
      expect(json['board']).to eq(['', '', '', '', '', '', '', '', ''])
      expect(json['current_player']).to eq('X')
      expect(json['status']).to eq('in_progress')
      expect(json['winner']).to be_nil
    end
  end

  describe 'GET /api/v1/games/:id' do
    let!(:game) { Game.create }

    it 'returns the game state' do
      get "/api/v1/games/#{game.id}"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json['id']).to eq(game.id)
      expect(json['board']).to eq(['', '', '', '', '', '', '', '', ''])
      expect(json['current_player']).to eq('X')
      expect(json['status']).to eq('in_progress')
    end

    it 'returns 404 for non-existent game' do
      get '/api/v1/games/99999'

      expect(response).to have_http_status(:not_found)

      json = JSON.parse(response.body)
      expect(json['error']).to eq('Game not found')
    end
  end

  describe 'POST /api/v1/games/:id/move' do
    let!(:game) { Game.create }

    context 'with valid move' do
      it 'makes a move and returns updated game state' do
        post "/api/v1/games/#{game.id}/move", params: { move: { position: 0 } }

        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json['board'][0]).to eq('X')
        expect(json['current_player']).to eq('O')
      end

      it 'detects winner' do
        game.update(board: ['X', 'X', '', 'O', 'O', '', '', '', ''], current_player: 'X')

        post "/api/v1/games/#{game.id}/move", params: { move: { position: 2 } }

        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json['status']).to eq('won')
        expect(json['winner']).to eq('X')
      end

      it 'detects draw' do
        game.update(board: ['X', 'O', 'X', 'X', 'O', 'O', 'O', 'X', ''], current_player: 'X')

        post "/api/v1/games/#{game.id}/move", params: { move: { position: 8 } }

        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json['status']).to eq('draw')
      end
    end

    context 'with invalid move' do
      it 'returns 422 for occupied cell' do
        game.update(board: ['X', '', '', '', '', '', '', '', ''])

        post "/api/v1/games/#{game.id}/move", params: { move: { position: 0 } }

        expect(response).to have_http_status(:unprocessable_entity)

        json = JSON.parse(response.body)
        expect(json['error']).to eq('Cell is already occupied')
      end

      it 'returns 422 for out of bounds position' do
        post "/api/v1/games/#{game.id}/move", params: { move: { position: 9 } }

        expect(response).to have_http_status(:unprocessable_entity)

        json = JSON.parse(response.body)
        expect(json['error']).to eq('Invalid position')
      end

      it 'returns 422 when game is finished' do
        game.update(status: 'won', winner: 'X')

        post "/api/v1/games/#{game.id}/move", params: { move: { position: 2 } }

        expect(response).to have_http_status(:unprocessable_entity)

        json = JSON.parse(response.body)
        expect(json['error']).to eq('Game is already finished')
      end
    end

    it 'returns 404 for non-existent game' do
      post '/api/v1/games/99999/move', params: { move: { position: 0 } }

      expect(response).to have_http_status(:not_found)

      json = JSON.parse(response.body)
      expect(json['error']).to eq('Game not found')
    end
  end

  describe 'POST /api/v1/games/:id/reset' do
    let!(:game) { Game.create(
      board: ['X', 'O', 'X', 'O', 'X', 'O', '', '', ''],
      current_player: 'O',
      status: 'in_progress'
    )}

    it 'resets the game' do
      post "/api/v1/games/#{game.id}/reset"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json['board']).to eq(['', '', '', '', '', '', '', '', ''])
      expect(json['current_player']).to eq('X')
      expect(json['status']).to eq('in_progress')
    end

    it 'returns 404 for non-existent game' do
      post '/api/v1/games/99999/reset'

      expect(response).to have_http_status(:not_found)

      json = JSON.parse(response.body)
      expect(json['error']).to eq('Game not found')
    end
  end
end
