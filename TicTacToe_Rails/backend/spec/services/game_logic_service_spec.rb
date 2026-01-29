require 'rails_helper'

RSpec.describe GameLogicService do
  describe '.valid_move?' do
    let(:empty_board) { ['', '', '', '', '', '', '', '', ''] }
    let(:partial_board) { ['X', 'O', '', '', '', '', '', '', ''] }

    context 'with valid moves' do
      it 'returns true for empty cell at position 0' do
        expect(GameLogicService.valid_move?(empty_board, 0)).to be true
      end

      it 'returns true for empty cell at position 4 (center)' do
        expect(GameLogicService.valid_move?(empty_board, 4)).to be true
      end

      it 'returns true for empty cell at position 8 (last)' do
        expect(GameLogicService.valid_move?(empty_board, 8)).to be true
      end

      it 'returns true for empty cells in partial board' do
        expect(GameLogicService.valid_move?(partial_board, 2)).to be true
        expect(GameLogicService.valid_move?(partial_board, 5)).to be true
      end
    end

    context 'with invalid moves' do
      it 'returns false for occupied cell' do
        expect(GameLogicService.valid_move?(partial_board, 0)).to be false
        expect(GameLogicService.valid_move?(partial_board, 1)).to be false
      end

      it 'returns false for out of bounds (negative)' do
        expect(GameLogicService.valid_move?(empty_board, -1)).to be false
      end

      it 'returns false for out of bounds (too large)' do
        expect(GameLogicService.valid_move?(empty_board, 9)).to be false
        expect(GameLogicService.valid_move?(empty_board, 10)).to be false
      end

      it 'returns false for nil position' do
        expect(GameLogicService.valid_move?(empty_board, nil)).to be false
      end
    end
  end

  describe '.check_winner' do
    context 'horizontal wins' do
      it 'detects top row win for X' do
        board = ['X', 'X', 'X', '', '', '', '', '', '']
        expect(GameLogicService.check_winner(board)).to eq('X')
      end

      it 'detects middle row win for O' do
        board = ['', '', '', 'O', 'O', 'O', '', '', '']
        expect(GameLogicService.check_winner(board)).to eq('O')
      end

      it 'detects bottom row win for X' do
        board = ['', '', '', '', '', '', 'X', 'X', 'X']
        expect(GameLogicService.check_winner(board)).to eq('X')
      end
    end

    context 'vertical wins' do
      it 'detects left column win for X' do
        board = ['X', '', '', 'X', '', '', 'X', '', '']
        expect(GameLogicService.check_winner(board)).to eq('X')
      end

      it 'detects middle column win for O' do
        board = ['', 'O', '', '', 'O', '', '', 'O', '']
        expect(GameLogicService.check_winner(board)).to eq('O')
      end

      it 'detects right column win for X' do
        board = ['', '', 'X', '', '', 'X', '', '', 'X']
        expect(GameLogicService.check_winner(board)).to eq('X')
      end
    end

    context 'diagonal wins' do
      it 'detects top-left to bottom-right diagonal win for X' do
        board = ['X', '', '', '', 'X', '', '', '', 'X']
        expect(GameLogicService.check_winner(board)).to eq('X')
      end

      it 'detects top-right to bottom-left diagonal win for O' do
        board = ['', '', 'O', '', 'O', '', 'O', '', '']
        expect(GameLogicService.check_winner(board)).to eq('O')
      end
    end

    context 'no winner' do
      it 'returns nil for empty board' do
        board = ['', '', '', '', '', '', '', '', '']
        expect(GameLogicService.check_winner(board)).to be_nil
      end

      it 'returns nil for incomplete game' do
        board = ['X', 'O', 'X', 'O', 'X', '', '', '', '']
        expect(GameLogicService.check_winner(board)).to be_nil
      end

      it 'returns nil for draw game' do
        board = ['X', 'O', 'X', 'X', 'O', 'O', 'O', 'X', 'X']
        expect(GameLogicService.check_winner(board)).to be_nil
      end
    end
  end

  describe '.check_draw?' do
    it 'returns true when board is full with no winner' do
      board = ['X', 'O', 'X', 'X', 'O', 'O', 'O', 'X', 'X']
      expect(GameLogicService.check_draw?(board)).to be true
    end

    it 'returns false when board has empty cells' do
      board = ['X', 'O', '', 'X', 'O', 'O', 'O', 'X', 'X']
      expect(GameLogicService.check_draw?(board)).to be false
    end

    it 'returns false when there is a winner' do
      board = ['X', 'X', 'X', 'O', 'O', '', '', '', '']
      expect(GameLogicService.check_draw?(board)).to be false
    end

    it 'returns false for empty board' do
      board = ['', '', '', '', '', '', '', '', '']
      expect(GameLogicService.check_draw?(board)).to be false
    end
  end

  describe 'WINNING_COMBINATIONS constant' do
    it 'has 8 winning combinations' do
      expect(GameLogicService::WINNING_COMBINATIONS.length).to eq(8)
    end

    it 'includes all row combinations' do
      expect(GameLogicService::WINNING_COMBINATIONS).to include([0, 1, 2])
      expect(GameLogicService::WINNING_COMBINATIONS).to include([3, 4, 5])
      expect(GameLogicService::WINNING_COMBINATIONS).to include([6, 7, 8])
    end

    it 'includes all column combinations' do
      expect(GameLogicService::WINNING_COMBINATIONS).to include([0, 3, 6])
      expect(GameLogicService::WINNING_COMBINATIONS).to include([1, 4, 7])
      expect(GameLogicService::WINNING_COMBINATIONS).to include([2, 5, 8])
    end

    it 'includes diagonal combinations' do
      expect(GameLogicService::WINNING_COMBINATIONS).to include([0, 4, 8])
      expect(GameLogicService::WINNING_COMBINATIONS).to include([2, 4, 6])
    end
  end
end
