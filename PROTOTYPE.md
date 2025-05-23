
# Technical Details:

## Tetrimino
- Abstract class
### Fields
- color pieceColor
  - Color for each piece.
- int centerX
  - x coordinate of center block.
- int centerY
  - y coordinate of center block.
### Methods
- void left()
  - Move tetrimino leftwards on screen.
- void right()
  - Move tetrimino towards rightside of screen.
- void counterclockwise()
  - Rotate tetrimino 90 degrees counterclockwise every call.
- void clockwise()
  - Rotate tetrimino 90 degrees clockwise every call.
- void softDrop()
  - Regular speed of tetrimino falling.
- void hardDrop()
  - Immediate drop once called.
- (new) int collision()
  - Determines location of tetrimino to be dropped based on other block configurations on the screen.
- (new) void initializeBlocks()
  - To be implemented differently depending on tetrimino configuration of blocks. Will initialize PVectors for each of the four blocks in the tetrimino.

## Board
### Fields
- int[][] board
  - Each integer denotes the color of the block in that spot. 0 denotes that the square is empty.
  - 10 x 20 board
- int score
- Tetrimino hold
    - This is the piece that will be held.
- boolean canHold
    - Checks if you have already used hold.
- LinkedList<Tetrimino> bag
    - bag will be implemented as a queue. The next 3 pieces in the queue will be shown.
    - Pieces will be added to the bag in groups of 7 (1 of each piece).
### Methods
- void clearRow(int r)
    - Clears row at r and increments score appropriately
- void gameOver()
    - Ends game if the board tops out
- void generateBag()
    - Adds 7 random things to bag
- void pieceDropped()
    - Clears rows if necessary and adds more things to bag if the bag is empty
- (new) void display()
    - Calls displayBoard(), displayScore(), displayHold(), displayBag()



# Project Design

![UMLDiagram](UMLdiagram.png)

The Board class will act as the "main" class, of which the Processing project will be made off of. It will deal with most of the functionality of the game, including score tracking, UI, tetrimino randomization, and clearing/bonuses. Each piece will inherit the Tetrimino class, and have small tweaks based on their shape and color.

# Intended pacing:

- 05/22: Start writing Tetrimino class(Sean) and Board class(Andy)
- 05/23: Continue working on classes
- 05/27: Complete Tetrimino and Board class
- 05/28: Write tPiece, jPiece, lPiece, oPiece, iPiece, zPiece, sPiece classes(half and half)
- 05/29: Upgrade visual appearance(Sean) / work on animation(Andy)
- 05/30: Continue work from previous day
- 06/02: Testing/tweaking issues; buffer day for any setbacks
- 06/03: Add two-player mode(Sean) / NES mode(Andy)
- 06/04: Continue building alternate modes
- 06/05: Implement new modes and fix bugs
- 06/06: Final testing of UI, revisions
