public class Tetrimino{

  color pieceColor = 255; //placeholder
  int centerX;
  int centerY;
  int type;
  int orientation;
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
    fill(pieceColor);
    for(PVector b : blocks){
      rect(centerX + b.x * BLOCKSIZE, centerY + b.y * BLOCKSIZE, BLOCKSIZE, BLOCKSIZE); //placeholder 20, change accordingly
    }
  }
  
  void collision() {
    
  }
  
  
  void keyPressed() {
  if (keyCode == DOWN) {
      softDrop();
  }
  }

}
