import java.util.Arrays;

public class Tetrimino{

  color pieceColor = color(200,200,50); //placeholder
  int centerX;
  int centerY;
  int offsetX;
  int offsetY;
  int piecetype;
  PVector[] blocks;
  int orientation;
  String lastSpin;

  Tetrimino(int x, int y, int type){
    lastSpin = "";
    piecetype = type;
    orientation = 0;
    if (type == IPIECE) {
      blocks = new PVector[]{new PVector(0,0), new PVector(-1,0), new PVector(1,0), new PVector(2,0)}; //center second left
      pieceColor = #00ffff;
      offsetX = 0;
      offsetY = 0;
    }
    if (type == LPIECE) {
      blocks = new PVector[]{new PVector(0,0), new PVector(-1,0), new PVector(1,0), new PVector(1,-1)}; //center bottom right 
      pieceColor = #0000ff;
      offsetX = 0;
      offsetY = 0;
    }
    if (type == JPIECE) { 
      blocks = new PVector[]{new PVector(0,0), new PVector(1,0), new PVector(-1,0), new PVector(-1,-1)}; //center bottom left 
      pieceColor = #ff7f00;
      offsetX = 0;
      offsetY = 0;
    }
    if (type == OPIECE) {
      blocks = new PVector[]{new PVector(0.5,0.5), new PVector(0.5,-0.5), new PVector(-0.5,0.5), new PVector(-0.5,-0.5)}; //center top left
      pieceColor = #ffff00;
      offsetX = BLOCKSIZE/2;
      offsetY = BLOCKSIZE/2;
    }
    if (type == TPIECE) {
      blocks = new PVector[]{new PVector(0,0), new PVector(1,0), new PVector(-1,0), new PVector(0,-1)}; //center
      pieceColor = #800080;
      offsetX = 0;
      offsetY = 0;
    }
    if (type == SPIECE) {
      blocks = new PVector[]{new PVector(0,0), new PVector(-1,0), new PVector(0,-1), new PVector(1,-1)}; //center bottom middle
      pieceColor = #00ff00;
      offsetX = 0;
      offsetY = 0;
    }
    if (type == ZPIECE) {
      blocks = new PVector[]{new PVector(0,0), new PVector(1,0), new PVector(0,-1), new PVector(-1,-1)};
      pieceColor = #ff0000;
      offsetX = 0;
      offsetY = 0;
    }
    centerX = x + offsetX;
    centerY = y + offsetY;
  }

  void left(){
    centerX -= BLOCKSIZE;
  }
  
  void right(){
    centerX += BLOCKSIZE;
  }
  
  void arrayCCW(PVector[] arr) {
    for (PVector b : arr) {     
      float temp = b.x;
      b.x = b.y;
      b.y = -temp;
    }
    orientation = (orientation + 3) % 4;
  }
  
  void arrayCW(PVector[] arr) {
    for (PVector b : arr) {      
      float temp = b.x;
      b.x = -b.y;
      b.y = temp;
    }
    orientation = (orientation + 1) % 4;
  }
  
  boolean rotateHelper(int[][] board, int dir, int xOff, int yOff) {
    centerX += xOff * BLOCKSIZE;
    centerY += yOff * BLOCKSIZE;
    if (dir == CLOCKWISE) {
      arrayCW(blocks);
    }
    if (dir == COUNTERCLOCKWISE) {
      arrayCCW(blocks);
    }
    
    for (PVector b : blocks) {
      int r = getRowNum(b);
      int c = getColNum(b);
      if (r >= board.length || c >= board[0].length || c < 0 || (r >= 0 && board[r][c] != 0)) {
        if (dir == CLOCKWISE) {
          arrayCCW(blocks); //rotate back if collision
        }
        if (dir == COUNTERCLOCKWISE) {
          arrayCW(blocks);
        }
        centerX -= xOff * BLOCKSIZE;
        centerY -= yOff * BLOCKSIZE;
        return false;
      }
    }
    

    return true;
  }
  
  int ccwKicks(int[][] board) {
    PVector[] priorities = new PVector[5];
    if (orientation == 0) priorities = new PVector[]{new PVector(0,0), new PVector(1,0), new PVector(1,1), new PVector(0,-2), new PVector(1, -2)};
    if (orientation == 1) priorities = new PVector[]{new PVector(0,0), new PVector(1,0), new PVector(1,-1), new PVector(0,2), new PVector(1,2)};
    if (orientation == 2) priorities = new PVector[]{new PVector(0,0), new PVector(-1, 0), new PVector(-1,1), new PVector(0,-2), new PVector(-1,-2)};
    if (orientation == 3) priorities = new PVector[]{new PVector(0,0), new PVector(1,0), new PVector(1,1), new PVector(0,2), new PVector(1, 2)};
    for (int i = 0; i < priorities.length; i++) {
      if (rotateHelper(board, COUNTERCLOCKWISE, (int) priorities[i].x, -(int) priorities[i].y)) {
        return i;
      }
    }
    return 0;
  }
  
  int cwKicks(int[][] board) {
    PVector[] priorities = new PVector[5];
    if (orientation == 3) priorities = new PVector[]{new PVector(0,0), new PVector(-1,0), new PVector(-1,-1), new PVector(0,2), new PVector(-1, 2)};
    if (orientation == 0) priorities = new PVector[]{new PVector(0,0), new PVector(-1,0), new PVector(-1,1), new PVector(0,-2), new PVector(-1,-2)};
    if (orientation == 1) priorities = new PVector[]{new PVector(0,0), new PVector(1, 0), new PVector(1,-1), new PVector(0,2), new PVector(1,2)};
    if (orientation == 2) priorities = new PVector[]{new PVector(0,0), new PVector(-1,0), new PVector(-1,-1), new PVector(0,-2), new PVector(-1,2)};
    for (int i = 0; i < priorities.length; i++) {
      if (rotateHelper(board, CLOCKWISE, (int) priorities[i].x, -(int) priorities[i].y)) {
        return i;
      }
    }
    return -1;
  }
  
  void rotatePiece(int[][] board, int dir) {
    int r = 0;
    if (dir == CLOCKWISE) {
      r = cwKicks(board);
    }

    if (dir == COUNTERCLOCKWISE) {
      r = ccwKicks(board);
    }
    if (r != -1) {   
      if (piecetype == TPIECE) {
        if (r == 2) lastSpin = "Mini T-Spin";
        else if (r == 4) lastSpin = "T-Spin"; 
        else if (r == 0 && orientation == 2 && (board[getRowNum(new PVector(-1, 1))][getColNum(new PVector(-1, 1))] != 0 && board[getRowNum(new PVector(-1, 1))][getColNum(new PVector(-1, 1))] != 0) && (board[getRowNum(new PVector(-1, -1))][getColNum(new PVector(-1, -1))] != 0 || board[getRowNum(new PVector(1, -1))][getColNum(new PVector(1, -1))] != 0)) { //hard coding doubles
          lastSpin = "T-Spin";
        }
      }
      else if (piecetype == ZPIECE) {
        if (r == 2) lastSpin = "Z-Spin";
      }
      else if (piecetype == SPIECE) {
        if (r == 2) lastSpin = "S-Spin";
      }
    }
  }
  
  
  void down(){
    centerY += BLOCKSIZE;
  }
  
  void display(){
    displayGhost();    
    strokeWeight(0.2);
    stroke(255);
    fill(pieceColor);
    for(PVector b : blocks){
      rect(centerX + b.x * BLOCKSIZE, centerY + b.y * BLOCKSIZE, BLOCKSIZE, BLOCKSIZE);
    }
    fill(255);
    //rect(centerX, centerY , BLOCKSIZE, BLOCKSIZE);
  }
  
  void displayatpos(int x, int y){
    strokeWeight(0.2);
    stroke(255);
    fill(pieceColor);
    for(PVector b : blocks){
      rect(x + b.x * BLOCKSIZE, y + b.y * BLOCKSIZE, BLOCKSIZE, BLOCKSIZE);
    }
  }
  
  void displayGhost() {
    Tetrimino ghost = new Tetrimino(centerX, centerY, piecetype);
    ghost.blocks = this.blocks;
    while (!ghost.leftrightCollision(b.board, 0, 1)) ghost.down();
    strokeWeight(0.2);
    stroke(255);
    fill(40);
    for(PVector b : ghost.blocks){
      rect(ghost.centerX + b.x * BLOCKSIZE - offsetX, ghost.centerY + b.y * BLOCKSIZE - offsetY, BLOCKSIZE, BLOCKSIZE);
    }
  }
  
  public int getRowNum(PVector v) { //v: displacement vector
    int newY = centerY + (int) (v.y * BLOCKSIZE);
    return (newY - BOARD_START_Y) / BLOCKSIZE;
  }
  
  public int getColNum(PVector v) {
    int newX = centerX + (int) (v.x * BLOCKSIZE);
    return (newX - BOARD_START_X) / BLOCKSIZE;
  }
  
  boolean leftrightCollision(int[][] board, int dx, int dy) { //returns false if you are allowed to move, true if there's something in the way (border, bottom, or other blocks)
    for (PVector b : blocks) {
      int r = getRowNum(b) + dy;
      int c = getColNum(b) + dx;
      if (r >= board.length || c >= board[0].length || c < 0 || (r >= 0 && board[r][c] != 0)) return true; //left/right check
    }
    return false;
  }
  
}
