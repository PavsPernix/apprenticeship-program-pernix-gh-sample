class GameService
  # Custom error classes
  class InvalidMoveError < StandardError; end
  class GameFinishedError < StandardError; end

  # Creates a new game with default values
  # @return [Game] - Newly created game
  def self.create_game
    Game.create!
  end

  # Makes a move on the game board
  # @param game [Game] - The game instance
  # @param position [Integer] - Position on board (0-8)
  # @raise [GameFinishedError] if game is already finished
  # @raise [InvalidMoveError] if move is invalid
  # @return [Game] - Updated game instance
  def self.make_move(game, position)
    # Check if game is already finished
    raise GameFinishedError, 'Game is already finished' if game.status != 'in_progress'

    # Validate the move
    unless GameLogicService.valid_move?(game.board, position)
      if position.nil? || position < 0 || position > 8
        raise InvalidMoveError, 'Invalid position'
      else
        raise InvalidMoveError, 'Cell is already occupied'
      end
    end

    # Make the move
    board = game.board.dup
    board[position] = game.current_player

    # Check for winner
    winner = GameLogicService.check_winner(board)
    if winner
      game.update!(
        board: board,
        status: 'won',
        winner: winner
      )
      return game
    end

    # Check for draw
    if GameLogicService.check_draw?(board)
      game.update!(
        board: board,
        status: 'draw'
      )
      return game
    end

    # Switch player and continue game
    next_player = game.current_player == 'X' ? 'O' : 'X'
    game.update!(
      board: board,
      current_player: next_player
    )

    game
  end

  # Resets the game to initial state
  # @param game [Game] - The game instance to reset
  # @return [Game] - Reset game instance
  def self.reset_game(game)
    game.update!(
      board: ['', '', '', '', '', '', '', '', ''],
      current_player: 'X',
      status: 'in_progress',
      winner: nil
    )

    game
  end
end
