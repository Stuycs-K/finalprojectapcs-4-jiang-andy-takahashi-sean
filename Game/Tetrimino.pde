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
    }
    if (type == JPIECE) {
      blocks = new PVector[]{new PVector(0,0), new PVector(-1,0), new PVector(0,-1), new PVector(0,-2)}; //center bottom right 
    }
    if (type == LPIECE) {
      blocks = new PVector[]{new PVector(0,0), new PVector(1,0), new PVector(0,-1), new PVector(0,-2)}; //center bottom left 
      // 0 1
      // 2 
      // 3
    }
    if (type == OPIECE) {
      blocks = new PVector[]{new PVector(0,0), new PVector(1,0), new PVector(0,1), new PVector(1,1)}; //center top left
    }
    if (type == TPIECE) {
      blocks = new PVector[]{new PVector(0,0), new PVector(1,0), new PVector(-1,0), new PVector(0,1)}; //center
    }
    if (type == ZPIECE) {
      blocks = new PVector[]{new PVector(0,0), new PVector(-1,0), new PVector(0,-1), new PVector(1,-1)}; //center bottom middle
    }
    if (type == SPIECE) {
      blocks = new PVector[]{new PVector(0,0), new PVector(1,0), new PVector(0,-1), new PVector(-1,-1)};
    }
  }

  void left(){
    centerX -= BLOCKSIZE;
  }
  
  void right(){
    centerX += BLOCKSIZE;
  }
  
  void counterclockwise(){
    for(PVector b : blocks){
      float temp = b.x;
      b.x = b.y;
      b.y = -temp;
    }
  }
  
  void clockwise(){
   for(PVector b : blocks){
      float temp = b.x;
      b.x = -b.y;
      b.y = temp;
    }
  }
  
  
  void softDrop(){
    centerY += BLOCKSIZE;
  }
  
  
  void hardDrop(){
    
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
  
  boolean collision(int[][] board, int dx, int dy, PVector[] state) { //returns false if you are allowed to move, true if there's something in the way (border, bottom, or other blocks)
    // dx / dy - how much movement is by (pass in for left/right movement)
    // state - 
    
    return true;
  }
  
}
