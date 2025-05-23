import java.util.Collections;
import java.util.LinkedList;

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
    strokeWeight(10);
    stroke(127);
    rect(200, 100, 400, 800);
  }
  

  
}
