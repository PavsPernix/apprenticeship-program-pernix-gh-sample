# TicTacToe Rails + React - Setup Guide

A step-by-step guide to get the TicTacToe game running on your local machine.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Detailed Setup](#detailed-setup)
  - [Backend Setup (Rails API)](#backend-setup-rails-api)
  - [Frontend Setup (React)](#frontend-setup-react)
- [Running the Application](#running-the-application)
- [Running Tests](#running-tests)
- [Troubleshooting](#troubleshooting)

---

## Prerequisites

Before you begin, ensure you have the following installed on your machine:

### Required Software

1. **Docker Desktop**
   - Download from: https://www.docker.com/products/docker-desktop
   - Make sure Docker Desktop is **running** before proceeding
   - Verify installation:
     ```bash
     docker --version
     # Should output: Docker version 20.x.x or higher
     ```

2. **Node.js (v20 or higher)** and **npm**
   - Download from: https://nodejs.org/
   - Verify installation:
     ```bash
     node --version
     # Should output: v20.x.x or higher

     npm --version
     # Should output: 10.x.x or higher
     ```

3. **Git**
   - Download from: https://git-scm.com/
   - Verify installation:
     ```bash
     git --version
     ```

---

## Quick Start

For those who want to get running quickly:

```bash
# 1. Clone the repository
git clone <repository-url>
cd apprenticeship-program-pernix-gh-sample
git checkout tictactoe_rails

# 2. Start Docker Desktop (if not already running)

# 3. Build Docker image for Rails
cd TicTacToe_Rails
docker build -t tictactoe-rails -f Dockerfile.rails .

# 4. Start the backend (in a terminal window)
docker run --rm -p 3000:3000 -v "${PWD}:/app" tictactoe-rails bash -c "cd /app/backend && bundle config set --local path 'vendor/bundle' && bundle install && bundle exec rails db:migrate && bundle exec rails server -b 0.0.0.0"

# 5. Start the frontend (in a NEW terminal window)
cd frontend
npm install
npm run dev

# 6. Open your browser to http://localhost:5173
```

---

## Detailed Setup

### Backend Setup (Rails API)

The backend uses Docker to run Rails, so you don't need Ruby installed locally.

#### Step 1: Navigate to Project Directory

```bash
cd TicTacToe_Rails
```

#### Step 2: Build the Docker Image

This creates a Docker image with Ruby and Rails installed:

```bash
docker build -t tictactoe-rails -f Dockerfile.rails .
```

**Note:** This may take 3-5 minutes on first run as it downloads Ruby and installs Rails.

#### Step 3: Install Ruby Gems

Install all required Ruby dependencies:

**For Windows (Git Bash or PowerShell):**
```bash
docker run --rm -v "${PWD}:/app" tictactoe-rails bash -c "cd /app/backend && bundle config set --local path 'vendor/bundle' && bundle install"
```

**For Mac/Linux:**
```bash
docker run --rm -v "$(pwd):/app" tictactoe-rails bash -c "cd /app/backend && bundle config set --local path 'vendor/bundle' && bundle install"
```

#### Step 4: Setup Database

Create and migrate the database:

**For Windows:**
```bash
docker run --rm -v "${PWD}:/app" tictactoe-rails bash -c "cd /app/backend && bundle config set --local path 'vendor/bundle' && bundle exec rails db:migrate"
```

**For Mac/Linux:**
```bash
docker run --rm -v "$(pwd):/app" tictactoe-rails bash -c "cd /app/backend && bundle config set --local path 'vendor/bundle' && bundle exec rails db:migrate"
```

✅ **Backend setup complete!** The Rails API is ready to run.

---

### Frontend Setup (React)

The frontend is a React application built with Vite.

#### Step 1: Navigate to Frontend Directory

```bash
cd frontend
```

#### Step 2: Install Dependencies

```bash
npm install
```

This installs React, Vite, Axios, and all other dependencies. Should take 1-2 minutes.

✅ **Frontend setup complete!** The React app is ready to run.

---

## Running the Application

You need to run **both** the backend and frontend simultaneously in **separate terminal windows**.

### Terminal 1: Start the Backend (Rails API)

Navigate to the project directory:
```bash
cd TicTacToe_Rails
```

**For Windows:**
```bash
docker run --rm -p 3000:3000 -v "${PWD}:/app" tictactoe-rails bash -c "cd /app/backend && bundle config set --local path 'vendor/bundle' && bundle exec rails server -b 0.0.0.0"
```

**For Mac/Linux:**
```bash
docker run --rm -p 3000:3000 -v "$(pwd):/app" tictactoe-rails bash -c "cd /app/backend && bundle config set --local path 'vendor/bundle' && bundle exec rails server -b 0.0.0.0"
```

**Expected Output:**
```
=> Booting Puma
=> Rails 7.2.3 application starting in development
=> Run `bin/rails server --help` for more startup options
Puma starting in single mode...
* Puma version: 7.x.x
* Min threads: 5
* Max threads: 5
* Environment: development
* Listening on http://0.0.0.0:3000
Use Ctrl-C to stop
```

✅ **Backend is running on http://localhost:3000**

---

### Terminal 2: Start the Frontend (React)

Open a **NEW terminal window** and navigate to the frontend directory:

```bash
cd TicTacToe_Rails/frontend
```

Start the development server:
```bash
npm run dev
```

**Expected Output:**
```
VITE v5.x.x  ready in xxx ms

➜  Local:   http://localhost:5173/
➜  Network: use --host to expose
➜  press h + enter to show help
```

✅ **Frontend is running on http://localhost:5173**

---

### Step 3: Play the Game!

1. Open your browser
2. Go to: **http://localhost:5173**
3. You should see the TicTacToe game board
4. Click on any cell to start playing!

**To Stop the Servers:**
- Press `Ctrl+C` in each terminal window

---

## Running Tests

### Backend Tests (RSpec)

Run the full test suite:

**For Windows:**
```bash
cd TicTacToe_Rails
docker run --rm -v "${PWD}:/app" tictactoe-rails bash -c "cd /app/backend && bundle config set --local path 'vendor/bundle' && bundle exec rspec"
```

**For Mac/Linux:**
```bash
cd TicTacToe_Rails
docker run --rm -v "$(pwd):/app" tictactoe-rails bash -c "cd /app/backend && bundle config set --local path 'vendor/bundle' && bundle exec rspec"
```

**With detailed output:**
```bash
# Windows
docker run --rm -v "${PWD}:/app" tictactoe-rails bash -c "cd /app/backend && bundle config set --local path 'vendor/bundle' && bundle exec rspec --format documentation"

# Mac/Linux
docker run --rm -v "$(pwd):/app" tictactoe-rails bash -c "cd /app/backend && bundle config set --local path 'vendor/bundle' && bundle exec rspec --format documentation"
```

**Expected Result:**
```
65 examples, 0 failures
Coverage report generated for RSpec to /app/backend/coverage.
Line Coverage: 84.44% (76 / 90)
```

### View Coverage Report

After running tests, open the coverage report:
```bash
# From TicTacToe_Rails directory
cd backend/coverage
open index.html  # Mac
start index.html # Windows
```

---

## Troubleshooting

### Problem: Docker is not running

**Error Message:**
```
ERROR: error during connect: ... cannot find the file specified
```

**Solution:**
1. Open Docker Desktop application
2. Wait for it to fully start (whale icon in system tray should be steady)
3. Try the command again

---

### Problem: Port 3000 already in use

**Error Message:**
```
Address already in use - bind(2) for "0.0.0.0" port 3000
```

**Solution:**
1. Stop any other Rails/web servers running on port 3000
2. Or change the port:
   ```bash
   docker run --rm -p 3001:3000 ...  # Use port 3001 instead
   ```
3. Update frontend API URL in `frontend/src/services/gameApi.js`:
   ```javascript
   const API_BASE_URL = 'http://localhost:3001/api/v1';
   ```

---

### Problem: Port 5173 already in use

**Error Message:**
```
Port 5173 is in use, trying another one...
```

**Solution:**
- Vite will automatically use another port (5174, 5175, etc.)
- Just use the URL shown in the terminal output

---

### Problem: CORS errors in browser console

**Error Message:**
```
Access to XMLHttpRequest ... has been blocked by CORS policy
```

**Solution:**
1. Make sure the backend is running on port 3000
2. Check that `backend/config/initializers/cors.rb` has:
   ```ruby
   origins "http://localhost:5173"
   ```
3. Restart the backend server

---

### Problem: Database migration errors

**Error Message:**
```
ActiveRecord::PendingMigrationError
```

**Solution:**
Run migrations again:
```bash
# Windows
docker run --rm -v "${PWD}:/app" tictactoe-rails bash -c "cd /app/backend && bundle config set --local path 'vendor/bundle' && bundle exec rails db:migrate"

# Mac/Linux
docker run --rm -v "$(pwd):/app" tictactoe-rails bash -c "cd /app/backend && bundle config set --local path 'vendor/bundle' && bundle exec rails db:migrate"
```

---

### Problem: Frontend shows blank page

**Solution:**
1. Check browser console (F12) for errors
2. Verify backend is running and accessible at http://localhost:3000
3. Check that frontend API URL is correct in `frontend/src/services/gameApi.js`
4. Clear browser cache and refresh

---

### Problem: Docker volume mounting issues on Windows

**Error Message:**
```
Error response from daemon: invalid mode: \app
```

**Solution:**
Use the correct path format for Windows:
```bash
# Instead of:
-v "$(pwd):/app"

# Use:
-v "${PWD}:/app"

# Or absolute path:
-v "C:/Users/YourName/path/to/TicTacToe_Rails:/app"
```

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────┐
│                    Browser                          │
│              http://localhost:5173                  │
│                                                     │
│  ┌─────────────────────────────────────────────┐  │
│  │          React Frontend (Vite)              │  │
│  │  - Game Component                           │  │
│  │  - Board Component                          │  │
│  │  - Cell Component                           │  │
│  │  - GameStatus Component                     │  │
│  └──────────────────┬──────────────────────────┘  │
└─────────────────────┼────────────────────────────────┘
                      │ HTTP Requests (Axios)
                      │ API: http://localhost:3000
                      ▼
┌─────────────────────────────────────────────────────┐
│          Rails API Backend (Docker)                 │
│              http://localhost:3000                  │
│                                                     │
│  ┌─────────────────────────────────────────────┐  │
│  │     API::V1::GamesController                │  │
│  └──────────────────┬──────────────────────────┘  │
│                     │                              │
│  ┌──────────────────▼──────────────────────────┐  │
│  │         GameService                         │  │
│  │  - create_game                              │  │
│  │  - make_move                                │  │
│  │  - reset_game                               │  │
│  └──────────────────┬──────────────────────────┘  │
│                     │                              │
│  ┌──────────────────▼──────────────────────────┐  │
│  │      GameLogicService                       │  │
│  │  - valid_move?                              │  │
│  │  - check_winner                             │  │
│  │  - check_draw?                              │  │
│  └──────────────────┬──────────────────────────┘  │
│                     │                              │
│  ┌──────────────────▼──────────────────────────┐  │
│  │         Game Model                          │  │
│  │  (SQLite Database)                          │  │
│  └─────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────┘
```

---

## Need Help?

If you encounter issues not covered in this guide:

1. Check that Docker Desktop is running
2. Verify Node.js version is 20+
3. Make sure both backend (port 3000) and frontend (port 5173) are running
4. Check browser console for errors (F12)
5. Review the main [README.md](README.md) for more details

---

## Next Steps

Once you have the application running:

1. Try playing a game to test all features
2. Test the winner detection (try all 8 winning combinations)
3. Test the draw scenario
4. Try the Reset and New Game buttons
5. Run the test suite to verify everything is working
6. Check out the code in `backend/app/services/` to understand the game logic

Happy coding! 🎮
