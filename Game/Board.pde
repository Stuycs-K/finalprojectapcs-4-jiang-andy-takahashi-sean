import java.util.Collections;
import java.util.LinkedList;

public class Board {   
  int[][] board;
  int score;
  Tetrimino hold;
  boolean canHold;
  LinkedList<Tetrimino> bag;
  
  public Board() {
    board = new int[10][20];
    canHold = true;
    hold = null;
    score = 0;
  }
  
  private generateBag() {
     
  }
  
  public void display() {
    fill(0);
    noStroke();
    rect(200, 200, 400, 800);
  }
  
}
