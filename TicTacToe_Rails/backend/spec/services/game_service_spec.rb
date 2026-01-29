require 'rails_helper'

RSpec.describe GameService do
  describe '.create_game' do
    it 'creates a new game with default values' do
      game = GameService.create_game

      expect(game).to be_persisted
      expect(game.board).to eq(['', '', '', '', '', '', '', '', ''])
      expect(game.current_player).to eq('X')
      expect(game.status).to eq('in_progress')
      expect(game.winner).to be_nil
    end
  end

  describe '.make_move' do
    let(:game) { Game.create }

    context 'with valid moves' do
      it 'updates the board at the specified position' do
        GameService.make_move(game, 0)
        expect(game.reload.board[0]).to eq('X')
      end

      it 'switches player from X to O' do
        GameService.make_move(game, 0)
        expect(game.reload.current_player).to eq('O')
      end

      it 'switches player from O to X' do
        game.update(current_player: 'O')
        GameService.make_move(game, 1)
        expect(game.reload.current_player).to eq('X')
      end

      it 'allows multiple moves in sequence' do
        GameService.make_move(game, 0) # X
        GameService.make_move(game, 1) # O
        GameService.make_move(game, 2) # X

        game.reload
        expect(game.board[0]).to eq('X')
        expect(game.board[1]).to eq('O')
        expect(game.board[2]).to eq('X')
        expect(game.current_player).to eq('O')
      end
    end

    context 'detecting winner' do
      it 'detects horizontal win and updates game status' do
        # X wins with top row
        game.update(board: ['X', 'X', '', 'O', 'O', '', '', '', ''], current_player: 'X')
        GameService.make_move(game, 2)

        game.reload
        expect(game.status).to eq('won')
        expect(game.winner).to eq('X')
      end

      it 'detects diagonal win' do
        # O wins with diagonal
        game.update(board: ['X', 'X', 'O', '', 'O', 'X', '', '', ''], current_player: 'O')
        GameService.make_move(game, 6)

        game.reload
        expect(game.status).to eq('won')
        expect(game.winner).to eq('O')
      end
    end

    context 'detecting draw' do
      it 'detects draw when board is full with no winner' do
        # Last move that results in draw
        game.update(board: ['X', 'O', 'X', 'X', 'O', 'O', 'O', 'X', ''], current_player: 'X')
        GameService.make_move(game, 8)

        game.reload
        expect(game.status).to eq('draw')
        expect(game.winner).to be_nil
      end
    end

    context 'with invalid moves' do
      it 'raises error for occupied cell' do
        game.update(board: ['X', '', '', '', '', '', '', '', ''])

        expect {
          GameService.make_move(game, 0)
        }.to raise_error(GameService::InvalidMoveError, 'Cell is already occupied')
      end

      it 'raises error for out of bounds position' do
        expect {
          GameService.make_move(game, 9)
        }.to raise_error(GameService::InvalidMoveError, 'Invalid position')
      end

      it 'raises error for negative position' do
        expect {
          GameService.make_move(game, -1)
        }.to raise_error(GameService::InvalidMoveError, 'Invalid position')
      end
    end

    context 'when game is finished' do
      it 'raises error when game is won' do
        game.update(status: 'won', winner: 'X')

        expect {
          GameService.make_move(game, 0)
        }.to raise_error(GameService::GameFinishedError, 'Game is already finished')
      end

      it 'raises error when game is draw' do
        game.update(status: 'draw')

        expect {
          GameService.make_move(game, 0)
        }.to raise_error(GameService::GameFinishedError, 'Game is already finished')
      end
    end
  end

  describe '.reset_game' do
    let(:game) { Game.create(
      board: ['X', 'O', 'X', 'O', 'X', 'O', '', '', ''],
      current_player: 'O',
      status: 'in_progress'
    )}

    it 'resets the board to empty' do
      GameService.reset_game(game)
      expect(game.reload.board).to eq(['', '', '', '', '', '', '', '', ''])
    end

    it 'resets current_player to X' do
      GameService.reset_game(game)
      expect(game.reload.current_player).to eq('X')
    end

    it 'resets status to in_progress' do
      game.update(status: 'won', winner: 'X')
      GameService.reset_game(game)

      game.reload
      expect(game.status).to eq('in_progress')
      expect(game.winner).to be_nil
    end
  end
end
