import java.util.Arrays;

public class Tetrimino{

  color pieceColor = color(200,200,50); //placeholder
  int centerX;
  int centerY;
  int offsetX;
  int offsetY;
  int piecetype;
  PVector[] blocks;

  Tetrimino(int x, int y, int type){
    piecetype = type;
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
    if (type == ZPIECE) {
      blocks = new PVector[]{new PVector(0,0), new PVector(-1,0), new PVector(0,-1), new PVector(1,-1)}; //center bottom middle
      pieceColor = #00ff00;
      offsetX = 0;
      offsetY = 0;
    }
    if (type == SPIECE) {
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
  }
  
  void arrayCW(PVector[] arr) {
    for (PVector b : arr) {      
      float temp = b.x;
      b.x = -b.y;
      b.y = temp;
    }
  }
  
  boolean rotateHelper(int[][] board, int dir) {
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
        if (dir == CLOCKWISE) { //rotate back if there was a collision
          arrayCCW(blocks);
        }
        if (dir == COUNTERCLOCKWISE) {
          arrayCW(blocks);
        }
        return false;
      }
    }
    //if no collision, rotation is done
    return true;
  }
  
  void rotatePiece(int[][] board, int dir) {
    if (!rotateHelper(board, dir)) { //if normal rotation fails, move it right 1
      right();
      if (!rotateHelper(board, dir)) {//if moving it right 1 fails, move it left 1
        left();
        left();
        if (!rotateHelper(board,dir)) {//if moving it left 1 fails, try moving it left 1 down 1
          down();
          if (!rotateHelper(board, dir)) {//if moving it left 1 down 1 fails, try moving it right 1 down 1
            right();
            right();
            if (!rotateHelper(board, dir)) { //try moving it right 1 up 1
              centerY -= BLOCKSIZE;
              centerY -= BLOCKSIZE;
              if (!rotateHelper(board, dir)) { //try moving it left 1 up 1
                left();
                left();
                if (!rotateHelper(board, dir)) { //give up
                  right();
                  down();
                } 
              } 
            } 
          }
        }
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
