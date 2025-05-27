import java.util.*;

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

Tetrimino current;
Board b;

void generateBag() {
  ArrayList<Tetrimino> temp = new ArrayList<Tetrimino>();
  temp.add(new Tetrimino(400, 130, IPIECE));
  temp.add(new Tetrimino(400, 130, JPIECE));
  temp.add(new Tetrimino(400, 130, LPIECE));
  temp.add(new Tetrimino(400, 130, OPIECE));
  temp.add(new Tetrimino(400, 130, TPIECE));
  temp.add(new Tetrimino(400, 130, ZPIECE));
  temp.add(new Tetrimino(400, 130, SPIECE));
  Collections.shuffle(temp);
  bag.addAll(temp);
}
  
void lockPiece() {
  for (PVector p : current.blocks) {
    b.board[current.getRowNum(p)][current.getColNum(p)] = current.pieceColor;
  }
  bag.remove(0);
  current = bag.get(0);
  updateBag();
}

void updateBag(){
  if(bag.size() <= 5){
    generateBag();
  }
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
    if (!current.leftrightCollision(b.board, 0, 1)) current.down();
  }
  if (keyCode == LEFT) {
    if (!current.leftrightCollision(b.board, -1, 0)) current.left();
  }
  if (keyCode == RIGHT) {
    if (!current.leftrightCollision(b.board, 1, 0)) current.right();
  }
  if (key == ' ') {
    while (!current.leftrightCollision(b.board, 0, 1)) current.down();
    lockPiece();
  }
  if (key == 'f' || key == 'F') {
    current.rotatePiece(b.board, CLOCKWISE);
  }
  if (key == 'a' || key == 'A') {
    current.rotatePiece(b.board, COUNTERCLOCKWISE);
  }
}


void draw() {
  background(255);
  b.displayBoard();
  displayBag();
  displayHold();
  displayScore();
  current.display();
  text("Col: " + current.getColNum(current.blocks[3]), 100, 200);
}


void setup() {
  size(800,900);
  background(255);
  b = new Board();
  current = new Tetrimino(400, 130, LPIECE);
  bag = new ArrayList<Tetrimino>();
  generateBag();
}
