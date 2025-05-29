public class Board {   
  color[][] board;
  
  public Board() {
    board = new color[20][10]; 
  }
  
  public int updateBoard() {
    int linesCleared = 0;
    for (int row = 0; row < 20; row++) {
      int count = 0;
      for (int col = 0; col < 10; col ++) {
        if (board[row][col] != 0) count++;
      }
      if (count == 10){
        clearRow(row);
        linesCleared++;
      }
    }
    return linesCleared;
  }
  
  public void clearRow(int r) {
    for (int row = r; row > 0; row--) {
      for (int col = 0; col < 10; col++) {
        board[row][col] = board[row-1][col];
      }
    }
    for (int col = 0; col < 10; col++) {
      board[0][col] = 0;
    }
  }
  
  public void displayBoard() { 
    fill(0);
    noStroke();
    //rect(BOARD_START_X, BOARD_START_Y, 400, 800);
    strokeWeight(0.2);
    stroke(255);
    for (int row = 0; row < 20; row++) {
      for (int col = 0; col < 10; col++) {
        fill(board[row][col]);
        rect(BOARD_START_X + col * BLOCKSIZE, BOARD_START_Y + row * BLOCKSIZE, BLOCKSIZE, BLOCKSIZE);
      }
    }
  }
  
}
