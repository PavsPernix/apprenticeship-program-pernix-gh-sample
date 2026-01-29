import Cell from './Cell';
import './Board.css';

function Board({ board, onCellClick, disabled }) {
  return (
    <div className="board">
      {board.map((cell, index) => (
        <Cell
          key={index}
          value={cell}
          onClick={() => onCellClick(index)}
          disabled={disabled}
        />
      ))}
    </div>
  );
}

export default Board;
