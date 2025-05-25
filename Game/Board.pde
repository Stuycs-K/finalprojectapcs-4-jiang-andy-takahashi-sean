public class Board {   
  int[][] board;
  
  public Board() {
    board = new int[20][10];
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
    rect(BOARD_START_X, BOARD_START_Y, 400, 800);
  }
  
}
