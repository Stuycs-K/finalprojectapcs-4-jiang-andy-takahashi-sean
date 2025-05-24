public class Tetrimino{
  
  color pieceColor;
  int centerX;
  int centerY;
  int type;
  PVector[] blocks;

  Tetrimino(int x, int y, int type){
    centerX = x;
    centerY = y;
    if (type == 0) { //I piece
      blocks = new PVector[]{new PVector(-1,0), new PVector(0,0), new PVector(1,0), new PVector(2,0)};
    }
    else if (type == 1) { //J piece
    
    }
    else if (type == 2) { //L piece
    
    }
    else if (type == 3) { //O piece
    
    }
    else if (type == 4) { //T piece
    
    }
    else if (type == 5) { // Z piece
    
    }
    else { // S piece
    
    }
  }
  
  

  void left(){
    centerX -= 1;
  }
  
  void right(){
    centerX += 1;
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
    centerY += 1;
  }
  
  
  void hardDrop(){
    
  }

  
  
  void display(){
    fill(pieceColor);
    for(PVector b : blocks){
      rect((centerX + b.x) * 20, (centerY + b.y) * 20, 20, 20); //placeholder 20, change accordingly
    }
  }
  
  void collision() {
    
  }
  

}
