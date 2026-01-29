import { useState, useEffect } from 'react';
import Board from './Board';
import GameStatus from './GameStatus';
import gameApi from '../services/gameApi';
import './Game.css';

function Game() {
  const [gameId, setGameId] = useState(null);
  const [board, setBoard] = useState(Array(9).fill(''));
  const [currentPlayer, setCurrentPlayer] = useState('X');
  const [status, setStatus] = useState('in_progress');
  const [winner, setWinner] = useState(null);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(false);

  // Create a new game on mount
  useEffect(() => {
    createNewGame();
  }, []);

  const createNewGame = async () => {
    try {
      setLoading(true);
      setError(null);
      const response = await gameApi.createGame();
      updateGameState(response.data);
    } catch (err) {
      setError('Failed to create game. Please try again.');
      console.error('Error creating game:', err);
    } finally {
      setLoading(false);
    }
  };

  const updateGameState = (gameData) => {
    setGameId(gameData.id);
    setBoard(gameData.board);
    setCurrentPlayer(gameData.current_player);
    setStatus(gameData.status);
    setWinner(gameData.winner);
  };

  const handleCellClick = async (position) => {
    if (!gameId || status !== 'in_progress' || loading) return;

    try {
      setLoading(true);
      setError(null);
      const response = await gameApi.makeMove(gameId, position);
      updateGameState(response.data);
    } catch (err) {
      const errorMessage = err.response?.data?.error || 'Failed to make move';
      setError(errorMessage);
      console.error('Error making move:', err);
    } finally {
      setLoading(false);
    }
  };

  const handleReset = async () => {
    if (!gameId || loading) return;

    try {
      setLoading(true);
      setError(null);
      const response = await gameApi.resetGame(gameId);
      updateGameState(response.data);
    } catch (err) {
      setError('Failed to reset game. Please try again.');
      console.error('Error resetting game:', err);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="game-container">
      <h1>Tic-Tac-Toe</h1>

      {error && (
        <div className="error-message">
          {error}
          <button onClick={() => setError(null)} className="error-close">
            ×
          </button>
        </div>
      )}

      <GameStatus
        status={status}
        currentPlayer={currentPlayer}
        winner={winner}
      />

      <Board
        board={board}
        onCellClick={handleCellClick}
        disabled={status !== 'in_progress' || loading}
      />

      <div className="game-controls">
        <button
          onClick={handleReset}
          disabled={loading}
          className="btn-reset"
        >
          Reset Game
        </button>
        <button
          onClick={createNewGame}
          disabled={loading}
          className="btn-new-game"
        >
          New Game
        </button>
      </div>

      {loading && <div className="loading-indicator">Processing...</div>}
    </div>
  );
}

export default Game;
