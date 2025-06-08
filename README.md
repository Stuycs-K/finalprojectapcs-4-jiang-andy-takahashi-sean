[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/YxXKqIeT)
# Project Description

PERIOD 4

Andy Jiang, Sean Takahashi

Group name: Stack Overflow

## Controls

Rotate counterclockwise - a
Rotate clockwise - f
Shift piece left - left arrow key
Shift piece right - right arrow key
Hold piece - c
Hard drop - space
Soft drop - down arrow key

## Rules
Our game has the same rules as Tetris, which are as follows:
    - Random tetriminos fall from the bottom and lock when they land on another block
    - When a row is full, it will clear and everything will shift down
    - When the stack gets too high, the game ends
    - There is some delay on the lock if you quickly make inputs when the piece reaches the bottom (wobble)
    - There is a kick system for rotations (SRS) that allows for special spins like T-spins

## Prototype

We will implement the same rules as the original TETRIS game. The 7 distinct tetriminos would be added to a queue (the “bag”) and cycled through. There will be a feature to set custom controls for hold, spin, and hard drop. ~We will also have a 2 player option as well.~ It will keep track of the score using multipliers like tetris, perfect clear, and t-spins along with the current speed of the blocks. There could be a feature to choose between classic (NES), modern, or 2 player.

At minimum, we would like to have a working modern TETRIS with the original features of the game included. By the end, it would be nice to have the option to switch between modes such as two player or NES.

# Intended usage:

The user will start off at level 1 with the slowest speed and an empty board. They will use the ~same keys as the default game for the different features: z~ (new) a key to rotate, left/right arrow keys to move the block horizontally, space bar to drop, c key to hold the block. As the levels increased based on the accumulated points, the blocks will drop faster. There will be a points, level, and lines tracker on the bottom-left of the screen, the held block on the top-left, three upcoming blocks on the top-right.   
