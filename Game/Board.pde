public class Board {   
  color[][] board;
  
  public Board() {
    board = new color[20][10]; 
  }

  public void clearRow(int r) {
    for (int row = r; row > 0; row--) {
      for (int col = 0; col < 10; col++) {
        board[row][col] = board[row-1][col];
      }
    }
  }
  
  public void displayBoard() { 
    fill(0);
    noStroke();
    //rect(BOARD_START_X, BOARD_START_Y, 400, 800);
    for (int row = 0; row < 20; row++) {
      for (int col = 0; col < 10; col++) {
        fill(board[row][col]);
        rect(BOARD_START_X + col * BLOCKSIZE, BOARD_START_Y + row * BLOCKSIZE, BLOCKSIZE, BLOCKSIZE);
      }
    }
  }
  
}
