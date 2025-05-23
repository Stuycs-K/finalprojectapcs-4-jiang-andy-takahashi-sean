import java.util.Collections;
import java.util.LinkedList;

public class Board {   
  int[][] board;
  int score;
  Tetrimino hold;
  boolean canHold;
  ArrayList<Tetrimino> bag;
  
  public Board() {
    board = new int[10][20];
    canHold = true;
    hold = null;
    score = 0;
    bag = new ArrayList<Tetrimino>();
    generateBag();
  }
  
  private void generateBag() {
    ArrayList<Tetrimino> group = new ArrayList<Tetrimino>();
    group.add(new iPiece());
    group.add(new jPiece());
    group.add(new lPiece());
    group.add(new oPiece());
    group.add(new sPiece());
    group.add(new tPiece());
    group.add(new zPiece());
    Collections.shuffle(group);
    for (int i = 0; i < 7; i++) {
      bag.add(group.get(i));
    }
  }
  
  public void clearRow() {
    
  }
  
  public void displayBoard() { 
    fill(0);
    strokeWeight(10);
    stroke(127);
    rect(200, 100, 400, 800);
    
    //gridlines
    
    //int x = 200;
    //for (int i = 0; i < 9; i++) {
    //  x += 40;
    //  line(x, 150, x, 950);
    //}
    //int y = 150;
    //for (int i = 0; i < 19; i++) {
    //  y += 40;
    //  line(200, y, 600, y);
    //}
  }
  
  
  
  
  public void displayBag() {
    fill(0);
    strokeWeight(10);
    stroke(127);
    rect(620,175, 100, 250);
  }
  
  public void displayHold() {
    fill(0);
    strokeWeight(10);
    stroke(127);
    rect(80,175, 100, 100);
  }
  
  public void displayScore() {
    fill(0);
    strokeWeight(10);
    stroke(127);
    rect(80, 500, 100, 200);
    
  }
  
  public void display() {
    displayBoard();
    displayBag();
    displayScore();
    displayHold();
  }
  
}
