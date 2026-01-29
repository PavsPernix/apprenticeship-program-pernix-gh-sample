class GameLogicService
  # All possible winning combinations on a 3x3 board
  # Rows: 0-1-2, 3-4-5, 6-7-8
  # Columns: 0-3-6, 1-4-7, 2-5-8
  # Diagonals: 0-4-8, 2-4-6
  WINNING_COMBINATIONS = [
    [0, 1, 2], # Top row
    [3, 4, 5], # Middle row
    [6, 7, 8], # Bottom row
    [0, 3, 6], # Left column
    [1, 4, 7], # Middle column
    [2, 5, 8], # Right column
    [0, 4, 8], # Diagonal top-left to bottom-right
    [2, 4, 6]  # Diagonal top-right to bottom-left
  ].freeze

  # Validates if a move is valid
  # @param board [Array<String>] - Current board state (array of 9 elements)
  # @param position [Integer] - Position to check (0-8)
  # @return [Boolean] - True if move is valid, false otherwise
  def self.valid_move?(board, position)
    return false if position.nil?
    return false if position < 0 || position > 8
    return false if board[position] && !board[position].empty?

    true
  end

  # Checks if there's a winner on the board
  # @param board [Array<String>] - Current board state
  # @return [String, nil] - Returns 'X' or 'O' if there's a winner, nil otherwise
  def self.check_winner(board)
    WINNING_COMBINATIONS.each do |combination|
      positions = combination.map { |pos| board[pos] }

      # Check if all three positions have the same non-empty value
      if positions.uniq.length == 1 && !positions.first.empty?
        return positions.first
      end
    end

    nil
  end

  # Checks if the game is a draw
  # @param board [Array<String>] - Current board state
  # @return [Boolean] - True if board is full and no winner, false otherwise
  def self.check_draw?(board)
    # Board must be full (no empty cells)
    return false if board.any?(&:empty?)

    # And there must be no winner
    check_winner(board).nil?
  end
end
