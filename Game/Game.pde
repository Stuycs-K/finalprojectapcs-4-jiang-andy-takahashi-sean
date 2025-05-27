import java.util.Arrays;

final int IPIECE = 0;
final int JPIECE = 1;
final int LPIECE = 2;
final int OPIECE = 3;
final int TPIECE = 4;
final int ZPIECE = 5;
final int SPIECE = 6;
final int BLOCKSIZE = 40;
final int BOARD_START_Y = 50;
final int BOARD_START_X = 200;
final int CLOCKWISE = 0;
final int COUNTERCLOCKWISE = 1;

ArrayList<Tetrimino> bag;
int score;
Tetrimino hold;
boolean canHold;

Tetrimino test;
Board b;

void generateBag() {

}
  

void displayBag() {
  fill(0);
  strokeWeight(10);
  stroke(127);
  rect(620,125, 100, 250);
}
  
void displayHold() {
  fill(0);
  strokeWeight(10);
  stroke(127);
  rect(80,125, 100, 100);
}
  
void displayScore() {
  fill(0);
  strokeWeight(10);
  stroke(127);
  rect(80, 450, 100, 200); 
}

void keyPressed() {
  if (keyCode == DOWN) {
    if (!test.leftrightCollision(b.board, 0, 1)) test.down();
  }
  if (keyCode == LEFT) {
    if (!test.leftrightCollision(b.board, -1, 0)) test.left();
  }
  if (keyCode == RIGHT) {
    if (!test.leftrightCollision(b.board, 1, 0)) test.right();
  }
  if (key == ' ') {
    while (!test.leftrightCollision(b.board, 0, 1)) test.down();
  }
  if (key == 'f' || key == 'F') {
    test.rotatePiece(b.board, CLOCKWISE);
  }
  if (key == 'a' || key == 'A') {
    test.rotatePiece(b.board, COUNTERCLOCKWISE);
  }
}


void draw() {
  background(255);
  b.displayBoard();
  displayBag();
  displayHold();
  displayScore();
  test.display();
  text("Col: " + test.getColNum(test.blocks[3]), 100, 200);
}


void setup() {
  size(800,900);
  background(255);
  b = new Board();
  test = new Tetrimino(400, 130, LPIECE);
}
