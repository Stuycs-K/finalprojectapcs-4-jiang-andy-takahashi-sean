# Dev Log: Sean Takahashi

This document must be updated daily every time you finish a work session.

## 2025-05-19: Brief description

Updated README to include brief summary description of project and extended description of MVP and additional favorable features to be included. Also wrote the intended usage of this project.

## 2025-05-20: Created pacing

Updated PROTOTYPE with pacing schedule. 

## 2025-05-22: Started Tetrimino class

Created abstract Tetrimino class and worked on class structure/methods

## 2025-05-23: Changing structure of tetriminos

Altered from having subclasses of tetriminos to a 2D array of PVectors and all different types of tetriminos

## 2025-05-27: Bag of tetriminos

Got bag of shuffled tetriminos to work

## 2025-05-28: Upgrade UI

Changed starting orientation of tetriminos to same as original game, added displays of tetriminos in bag and hold


## 2025-05-29: Score hardcode + displaying game stats

Added basic multiplier score calculation and added display of score, lines cleared, and current level


## 2025-05-30: Add different drop speeds

Implemented levels based on lines cleared and different gravitational strength based on levels to vary drop speed


## 2025-06-01: Fixed level/line incrementation

Lines cleared was being incremented twice per tick so deleted one occurence, and fixed to level up when greater or equal to 10 instead of greater than 10.


## 2025-06-02: Fixed hold display, added modes

Streamlined orientation when holding to fit in display; made start, game, end modes with proper displays


## 2025-06-03: Clean up displays and add buttons

Made keypressed only work during gameplay to prevent blocks dropping at game start display; added game over buttons and changed spacing; fixed order of top 5 scores and update algorithm
