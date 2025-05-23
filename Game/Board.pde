import java.util.Collections;
import java.util.LinkedList;

public class Board {   
  int[][] board;
  
  public Board() {
    board = new int[10][20];
  }
  
<<<<<<< HEAD
  private void generateBag() {
    bag = new LinkedList<Tetrimino>();
    bag.add(new iPiece(3, 0));
    bag.add(new jPiece(3, 0));
    bag.add(new lPiece(3, 0));
    bag.add(new oPiece(3, 0));
    bag.add(new sPiece(3, 0));
    bag.add(new tPiece(3, 0));
    bag.add(new zPiece(3, 0));
    Collections.shuffle(bag);
=======
  public void clearRow(int r) {
    for (int row = r; row > 0; row--) {
      for (int col = 0; col < 10; col++) {
        board[row][col] = board[row-1][col];
      }
    }
>>>>>>> add6672b2852ce6c5e5e5a8def4dbfde40ec49f7
  }
  
  public void displayBoard() { 
    fill(0);
    strokeWeight(10);
    stroke(127);
    rect(200, 100, 400, 800);
  }
  

  
}
