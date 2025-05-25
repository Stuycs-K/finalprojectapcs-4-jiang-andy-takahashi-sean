public class Board {   
  int[][] board;
  
  public Board() {
    board = new int[10][20];
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
    rect(200, 100, 400, 800);
  }
  
}
