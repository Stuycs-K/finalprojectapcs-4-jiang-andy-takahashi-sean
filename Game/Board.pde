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
  
  private void generateBag() {
     
  }
  
  public void display() {
    fill(0);
    noStroke();
    rect(200, 150, 400, 800);
    int x = 200;
    for (int i = 0; i < 9; i++) {
      x += 40;
      fill()
    }
  }
  
}
