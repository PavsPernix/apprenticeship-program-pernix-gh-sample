class Game < ApplicationRecord
  # Validations
  validates :status, inclusion: { in: ['in_progress', 'won', 'draw'] }
  validates :current_player, inclusion: { in: ['X', 'O'] }

  # Serialize board as JSON
  serialize :board, coder: JSON

  # Ensure board is always an array after initialization
  after_initialize :ensure_board_is_array

  private

  def ensure_board_is_array
    self.board = JSON.parse(board) if board.is_a?(String)
  end
end
