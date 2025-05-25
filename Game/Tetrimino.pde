public class Tetrimino{

  color pieceColor = color(200,200,50); //placeholder
  int centerX;
  int centerY;
  PVector[] blocks;

  Tetrimino(int x, int y, int type){
    centerX = x;
    centerY = y;
    if (type == IPIECE) {
      blocks = new PVector[]{new PVector(0,0), new PVector(-1,0), new PVector(1,0), new PVector(2,0)}; //center second left
      pieceColor = #00ffff;
    }
    if (type == JPIECE) {
      blocks = new PVector[]{new PVector(0,0), new PVector(-1,0), new PVector(0,-1), new PVector(0,-2)}; //center bottom right 
      pieceColor = #0000ff;
    }
    if (type == LPIECE) {
      blocks = new PVector[]{new PVector(0,0), new PVector(1,0), new PVector(0,-1), new PVector(0,-2)}; //center bottom left 
      pieceColor = #ff7f00;
      // 0 1
      // 2 
      // 3
    }
    if (type == OPIECE) {
      blocks = new PVector[]{new PVector(0,0), new PVector(1,0), new PVector(0,1), new PVector(1,1)}; //center top left
      pieceColor = #ffff00;
    }
    if (type == TPIECE) {
      blocks = new PVector[]{new PVector(0,0), new PVector(1,0), new PVector(-1,0), new PVector(0,1)}; //center
      pieceColor = #800080;
    }
    if (type == ZPIECE) {
      blocks = new PVector[]{new PVector(0,0), new PVector(-1,0), new PVector(0,-1), new PVector(1,-1)}; //center bottom middle
      pieceColor = #ff0000;
    }
    if (type == SPIECE) {
      blocks = new PVector[]{new PVector(0,0), new PVector(1,0), new PVector(0,-1), new PVector(-1,-1)};
      pieceColor = #00ff00;
    }
  }

  void left(){
    centerX -= BLOCKSIZE;
  }
  
  void right(){
    centerX += BLOCKSIZE;
  }
  
  void ccwHelper(PVector b) {
    float temp = b.x;
    b.x = b.y;
    b.y = -temp;
  }
  
  void cwHelper(PVector b) {
    float temp = b.x;
    b.x = -b.y;
    b.y = temp;
  }
  
  void counterclockwise(){
    for(PVector b : blocks){
      ccwHelper(b);
    }
  }
  
  void clockwise(){
   for(PVector b : blocks){
      cwHelper(b);
    }
  }
  
  void down(){
    centerY += BLOCKSIZE;
  }

  
  
  void display(){
    //strokeWeight(4);
    //stroke(20);
    noStroke();
    fill(pieceColor);
    for(PVector b : blocks){
      rect(centerX + b.x * BLOCKSIZE, centerY + b.y * BLOCKSIZE, BLOCKSIZE, BLOCKSIZE);
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
      if (r >= board.length || c >= board[0].length || c < 0) return true; //left/right check
    }
    return false;
  }
  
  boolean rotationCollision(int[][] board, PVector[] rot) {
    for (PVector b : rot) {
      int r = getRowNum(b);
      int c = getColNum(b);
      if (r >= board.length || c >= board[0].length || c < 0) return true;
    }
    
    return false;
  }
  
}
