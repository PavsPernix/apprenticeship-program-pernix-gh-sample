# TicTacToe Rails + React

A full-stack Tic-Tac-Toe web application built with Rails API backend and React frontend, following Test-Driven Development (TDD) and SOLID principles.

## Technology Stack

### Backend
- **Rails 7.2** (API mode)
- **SQLite** database
- **RSpec** for testing
- **SimpleCov** for code coverage (84.44%)
- **Docker** for containerized development
- **CORS** enabled for React frontend

### Frontend
- **React 18** with **Vite**
- **Axios** for HTTP requests
- Functional components with hooks
- Modern CSS with Grid layout

## Project Structure

```
TicTacToe_Rails/
├── backend/              # Rails API application
│   ├── app/
│   │   ├── models/       # Game model
│   │   ├── controllers/  # API endpoints (Api::V1::GamesController)
│   │   └── services/     # Business logic (GameService, GameLogicService)
│   ├── spec/             # RSpec tests (65 examples, 0 failures)
│   │   ├── models/       # Model tests
│   │   ├── services/     # Service tests
│   │   └── requests/     # API integration tests
│   └── config/           # Rails configuration
├── frontend/             # React + Vite application
│   └── src/
│       ├── components/   # Game, Board, Cell, GameStatus
│       └── services/     # API client (gameApi.js)
└── README.md
```

## Features

- **Create New Game**: Start a fresh game with an empty board
- **Make Moves**: Click cells to place X or O
- **Winner Detection**: Automatically detects all 8 winning combinations
- **Draw Detection**: Identifies when the board is full with no winner
- **Reset Game**: Clear the board and start over
- **Error Handling**: User-friendly error messages for invalid moves
- **Real-time Updates**: Board state synced with backend
- **Loading States**: Visual feedback during API calls

## Database Design

**Game Model:**
- `board`: JSON array of 9 elements (3x3 grid)
- `current_player`: 'X' or 'O'
- `status`: 'in_progress', 'won', or 'draw'
- `winner`: 'X', 'O', or null
- Timestamps (created_at, updated_at)

## API Endpoints

All endpoints are under `/api/v1/games`:

| Method | Endpoint | Description | Response |
|--------|----------|-------------|----------|
| POST | `/api/v1/games` | Create new game | 201 Created |
| GET | `/api/v1/games/:id` | Get game state | 200 OK |
| POST | `/api/v1/games/:id/move` | Make a move | 200 OK / 422 Error |
| POST | `/api/v1/games/:id/reset` | Reset game | 200 OK |

### Request/Response Examples

**Create Game:**
```bash
POST /api/v1/games
Response: {
  "id": 1,
  "board": ["", "", "", "", "", "", "", "", ""],
  "current_player": "X",
  "status": "in_progress",
  "winner": null
}
```

**Make Move:**
```bash
POST /api/v1/games/1/move
Body: { "move": { "position": 0 } }
Response: {
  "id": 1,
  "board": ["X", "", "", "", "", "", "", "", ""],
  "current_player": "O",
  "status": "in_progress",
  "winner": null
}
```

## Setup Instructions

### Prerequisites
- **Docker Desktop** (running)
- **Node.js 20+** and npm

### Backend Setup (Rails with Docker)

1. Navigate to the project directory:
```bash
cd TicTacToe_Rails
```

2. Build the Docker image:
```bash
docker build -t tictactoe-rails -f Dockerfile.rails .
```

3. Install Ruby gems:
```bash
docker run --rm -v "/d/Git/PavsPernix/apprenticeship-program-pernix-gh-sample/TicTacToe_Rails://app" tictactoe-rails bash -c "cd /app/backend && bundle config set --local path 'vendor/bundle' && bundle install"
```

4. Run database migrations:
```bash
docker run --rm -v "/d/Git/PavsPernix/apprenticeship-program-pernix-gh-sample/TicTacToe_Rails://app" tictactoe-rails bash -c "cd /app/backend && bundle config set --local path 'vendor/bundle' && bundle exec rails db:migrate"
```

5. Start the Rails server:
```bash
docker run --rm -p 3000:3000 -v "/d/Git/PavsPernix/apprenticeship-program-pernix-gh-sample/TicTacToe_Rails://app" tictactoe-rails bash -c "cd /app/backend && bundle config set --local path 'vendor/bundle' && bundle exec rails server -b 0.0.0.0"
```

The API will be available at `http://localhost:3000`

### Frontend Setup (React with Vite)

1. Navigate to the frontend directory:
```bash
cd TicTacToe_Rails/frontend
```

2. Install dependencies (if not already done):
```bash
npm install
```

3. Start the development server:
```bash
npm run dev
```

The React app will be available at `http://localhost:5173`

## Running Tests

### Backend Tests (RSpec)

Run all tests:
```bash
docker run --rm -v "/d/Git/PavsPernix/apprenticeship-program-pernix-gh-sample/TicTacToe_Rails://app" tictactoe-rails bash -c "cd /app/backend && bundle config set --local path 'vendor/bundle' && bundle exec rspec"
```

Run with documentation format:
```bash
docker run --rm -v "/d/Git/PavsPernix/apprenticeship-program-pernix-gh-sample/TicTacToe_Rails://app" tictactoe-rails bash -c "cd /app/backend && bundle config set --local path 'vendor/bundle' && bundle exec rspec --format documentation"
```

**Test Coverage:**
- 65 examples, 0 failures
- Line coverage: 84.44%
- Coverage report: `backend/coverage/index.html`

## SOLID Principles Implementation

### Single Responsibility Principle
- **Game Model**: Data persistence only
- **GameLogicService**: Pure game logic (win detection, validation)
- **GameService**: Orchestrates game operations
- **GamesController**: HTTP request/response handling only

### Open/Closed Principle
- Winning combinations defined as constant (easy to extend)
- Services can be extended without modifying existing code

### Dependency Inversion
- Controller depends on Service abstraction
- Services can be mocked for testing
- Separation of concerns enables easy testing

## Test-Driven Development (TDD)

This project follows strict TDD methodology:

1. **Red Phase**: Write failing tests first
2. **Green Phase**: Write minimal code to pass tests
3. **Refactor Phase**: Improve code while keeping tests green

### Test Structure

- **Model Tests** (10 examples): Validations, defaults, serialization
- **GameLogicService Tests** (27 examples): All 8 winning combinations, draw detection, validation
- **GameService Tests** (16 examples): Game operations, error handling
- **API Controller Tests** (12 examples): Request/response, error codes

## Manual Testing Scenarios

### 1. Winning Combinations
Test all 8 winning patterns:
- Rows: [0,1,2], [3,4,5], [6,7,8]
- Columns: [0,3,6], [1,4,7], [2,5,8]
- Diagonals: [0,4,8], [2,4,6]

### 2. Draw Scenario
Fill the board without a winner:
```
X | O | X
---------
X | O | O
---------
O | X | X
```

### 3. Invalid Moves
- Click an occupied cell
- Try to move after game ends

### 4. Reset Functionality
- Reset during gameplay
- Reset after win/draw

## Development Notes

- Backend runs in Docker for consistent environment
- Frontend uses Vite for fast hot-reload
- CORS configured for localhost:5173
- JSON serialization for board state
- Custom error classes for game logic

## Future Enhancements

- Player names and scoring system
- Multiplayer with WebSockets
- AI opponent with minimax algorithm
- Game history and replay
- Responsive mobile design
- Dark mode toggle

## License

This project is for educational purposes.

## Contributors

- Developed following Scrum methodology
- Test-Driven Development approach
- SOLID principles adherence

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
