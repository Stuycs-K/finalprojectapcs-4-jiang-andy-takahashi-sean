public class Tetrimino{
  
  color pieceColor;
  int centerX;
  int centerY;
  PVector[][] blocks;

  Tetrimino(int x, int y){
    centerX = x;
    centerY = y;
    blocks = new PVector[7][4];
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
