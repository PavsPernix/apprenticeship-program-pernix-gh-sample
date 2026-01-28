# 📘 BDD Documentation – Tic-Tac-Toe Project

This document describes the system behavior using **Behavior-Driven Development (BDD)**, based on the defined user stories for the Tic-Tac-Toe project.
Scenarios are written using **Gherkin syntax** (Given / When / Then) and are compatible with **Cucumber**.

---

## 🧩 User Story 1: Game Start

**Description**
As a player, I want to start a new Tic-Tac-Toe game so that I can play against another player.

### Scenario: Start a new game with an empty grid
```gherkin
Given the player opens the game
When a new game is started
Then an empty 3x3 grid is displayed
And no "X" or "O" marks are present on the board
```

### Scenario: Choose player symbol
```gherkin
Given the player starts a new game
When the player chooses to play as "X"
Then the player is assigned the symbol "X"
And the opponent is assigned the symbol "O"
```

### Scenario: Display initial turn
```gherkin
Given the game has started
When the board is displayed
Then the current player's turn is clearly shown
```

---

## 🧩 User Story 2: Make a Move

**Description**
As a player, I want to select a cell on the grid to make my move.

### Scenario: Place a mark on an empty cell
```gherkin
Given it is the current player's turn
And the selected cell is empty
When the player selects the cell
Then the cell displays the player's mark
```

### Scenario: Switch turn after a valid move
```gherkin
Given a player has made a valid move
When the move is completed
Then the turn switches to the other player
```

### Scenario: Prevent move on an occupied cell
```gherkin
Given a cell already contains a mark
When the player attempts to select that cell
Then the move is not allowed
And the turn does not change
```

---

## 🧩 User Story 3: Winner Determination

**Description**
As a player, I want the game to automatically determine whether I have won, lost, or tied.

### Scenario: Win by row
```gherkin
Given a player has three identical marks in a row
When the board state is checked
Then the system declares that player as the winner
```

### Scenario: Win by column
```gherkin
Given a player has three identical marks in a column
When the board state is checked
Then the system declares that player as the winner
```

### Scenario: Win by diagonal
```gherkin
Given a player has three identical marks in a diagonal
When the board state is checked
Then the system declares that player as the winner
```

### Scenario: Draw game
```gherkin
Given all cells on the board are filled
And there is no winner
When the game state is checked
Then the system declares a draw
```

---

## 🧩 User Story 4: Restart Game

**Description**
As a player, I want to restart the game to start a new match.

### Scenario: Restart the game board
```gherkin
Given a game is in progress or finished
When the player presses the restart button
Then the board is cleared
```

### Scenario: Re-select symbols after restart
```gherkin
Given the game has been restarted
When the player starts a new game
Then the player can choose between "X" and "O" again
```

---

## 🧩 User Story 5: Intuitive User Interface (UI)

**Description**
As a player, I want a clear and easy-to-understand user interface.

### Scenario: Clear board visualization
```gherkin
Given the game has loaded
When the board is displayed
Then the grid is clearly visible
And the cells are well defined
```

### Scenario: Display game status
```gherkin
Given the game is in progress
When the turn changes or the game ends
Then the game status is clearly displayed
```

---

## 🧩 User Story 6: Local Multiplayer Mode

**Description**
As a player, I want to play against another player on the same device.

### Scenario: Two players playing locally
```gherkin
Given local multiplayer mode is active
When players take turns making moves
Then the system alternates turns correctly
```

### Scenario: Show result to both players
```gherkin
Given the game has finished
When there is a winner or a draw
Then the result is visible to both players
```

---

## 🧩 User Story 7: Play Against the Computer (AI)

**Description**
As a player, I want to play against the computer.

### Scenario: Select play against computer mode
```gherkin
Given the player starts a new game
When the player selects "Player vs Computer" mode
Then the system assigns the computer as the opponent
```

### Scenario: Computer makes a valid move
```gherkin
Given it is the computer's turn
When the AI makes a move
Then it places its mark in a valid empty cell
```

### Scenario: Configure AI difficulty
```gherkin
Given the player chooses to play against the computer
When the player selects a difficulty level
Then the AI behavior adapts to the selected difficulty
```

---
