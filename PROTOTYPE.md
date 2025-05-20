
# Technical Details:

## Tetrimino
- Abstract class
### Fields
- color pieceColor
- int centerX
- int centerY
### Methods (abstract)
- void left()
- void right()
- void counterclockwise()
- void clockwise()
- void softDrop()
- void hardDrop()

## Board
### Fields
- int[10][20] board
    - Each integer denotes the color of the block in that spot .
- int score
- Tetrimino hold
    - This is the piece that will be held .
- boolean canHold
    - Checks if you have already used hold.
- LinkedList<Tetrimino> bag
    - bag will be implemented as a queue. The next 3 pieces in the queue will be shown.
    - Pieces will be added to the bag in groups of 7 (1 of each piece).
### Methods
- void clearRow()
    - Increments score appropriately
- void gameOver()
    - Ends game if the board tops out


# Project Design

UML Diagrams and descriptions of key algorithms, classes, and how things fit together.



# Intended pacing:

How you are breaking down the project and who is responsible for which parts.

A timeline with expected completion dates of parts of the project. (CHANGE THIS!!!!!)
