abstract class Tetrimino{
  
  color pieceColor;
  int centerX;
  int centerY;

  void left(){
    centerX -= 1;
  }
  
  void right(){
    centerX += 1;
  }
  
  void counterclockwise(){
  }
  
  void clockwise(){
  }
  
  
  void softDrop(){
    centerY -= 1; //fix later
  }
  
  
  void hardDrop(){
    
  }
  
  

}
