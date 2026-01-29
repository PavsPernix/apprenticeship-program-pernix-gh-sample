import './GameStatus.css';

function GameStatus({ status, currentPlayer, winner }) {
  const getMessage = () => {
    if (status === 'won') {
      return `Player ${winner} wins!`;
    }
    if (status === 'draw') {
      return "It's a draw!";
    }
    return `Player ${currentPlayer}'s turn`;
  };

  const getStatusClass = () => {
    if (status === 'won') return 'status-won';
    if (status === 'draw') return 'status-draw';
    return 'status-playing';
  };

  return (
    <div className={`game-status ${getStatusClass()}`}>
      <h2>{getMessage()}</h2>
    </div>
  );
}

export default GameStatus;
