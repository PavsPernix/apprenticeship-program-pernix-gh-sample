import './Cell.css';

function Cell({ value, onClick, disabled }) {
  return (
    <button
      className={`cell ${value ? 'filled' : ''}`}
      onClick={onClick}
      disabled={disabled || value !== ''}
    >
      {value}
    </button>
  );
}

export default Cell;
