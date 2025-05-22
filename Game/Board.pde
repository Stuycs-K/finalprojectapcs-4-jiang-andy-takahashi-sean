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
  }
  
  private generateBag() {
     
  }
  
}
