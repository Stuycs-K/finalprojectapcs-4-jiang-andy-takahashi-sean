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
int lines = 0;
int score = 0;
int level = 1;

ArrayList<Tetrimino> bag;
List<Float> speed = Arrays.asList(0.016667, 0.021017, 0.026977, 0.035256, 0.04693, 0.06361, 0.0879, 0.1236, 0.1775, 0.2598, 0.388, 0.59, 0.92, 1.46, 2.36);

boolean canHold;
Tetrimino hold;

Tetrimino current;
Board b;

int framesSinceInput = 0;
int framesUntilLock = 200;

void generateBag() {
  ArrayList<Tetrimino> temp = new ArrayList<Tetrimino>();
  temp.add(new Tetrimino(360, 130, IPIECE));
  temp.add(new Tetrimino(360, 130, JPIECE));
  temp.add(new Tetrimino(360, 130, LPIECE));
  temp.add(new Tetrimino(360, 130, OPIECE));
  temp.add(new Tetrimino(360, 130, TPIECE));
  temp.add(new Tetrimino(360, 130, ZPIECE));
  temp.add(new Tetrimino(360, 130, SPIECE));
  Collections.shuffle(temp);
  bag.addAll(temp);
}

void tick() {
  if (frameCount % 20 == 0) {
    if (!current.leftrightCollision(b.board, 0, 1)) { //if no collision down, move down
      framesUntilLock = 200;
      current.down();
    }
    else if (framesSinceInput <= 30 && framesUntilLock > 0) { //if there was a recent input and it hasn't been stuck for too long, delay for a while
      framesUntilLock -= 20;
    }
    else lockPiece();
  }
}

void lockPiece() {
  for (PVector p : current.blocks) {
    b.board[current.getRowNum(p)][current.getColNum(p)] = current.pieceColor;
  }
  bag.remove(0);
  current = bag.get(0);
  updateBag();
  calculateScore(b.updateBoard());
  canHold = true;
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
  rect(640,125, 200, 350);
  
  Tetrimino temp = bag.get(1);
  temp.displayatpos(720, 150);
  
  temp = bag.get(2);
  temp.displayatpos(720, 275);
  
  temp = bag.get(3);
  temp.displayatpos(720, 425);
  
}
  
void displayHold() {
  fill(0);
  strokeWeight(10);
  stroke(127);
  rect(30,125, 150, 150);
  
  if(hold != null){
    hold.displayatpos(80, 180);
  }
}
 
void holdPiece() {
  if (hold == null) {
    hold = current;
    bag.remove(0);
    current = bag.get(0);
  }
  else {
    if (canHold) {
      Tetrimino temp = hold;
      hold = current;
      current = temp;
      canHold = false;
    }
  }
}
  
void displayScore() {
  fill(0);
  strokeWeight(10);
  stroke(127);
  rect(30, 430, 150, 400); 
  
  fill(255);
  strokeWeight(0);
  rect(50, 500, 110, 40);
  
  fill(255);
  strokeWeight(0);
  rect(50, 635, 110, 40); 
  
  fill(255);
  strokeWeight(0);
  rect(50, 770, 110, 40); 
}

void calculateScore(int clear){
  if(clear == 0) return;
  
  if(clear == 1){
    score += 100 * level;
  }
  
  if(clear == 2){
    score += 300 * level;
  }
  
  if(clear == 3){
    score += 500 * level;
  }
  
  if(clear == 4){
    score += 800 * level;
  }
  
  lines += clear;

}

void keyPressed() {
  framesSinceInput = 0;
  if (keyCode == DOWN) {
    if (!current.leftrightCollision(b.board, 0, 1)) current.down();
    else lockPiece();
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
  if (key == 'c' || key == 'C') {
    holdPiece();
  }
}


void draw() {
  background(255);
  b.displayBoard();
  displayBag();
  displayHold();
  displayScore();
  current.display();
  tick();
  framesSinceInput++;
}


void setup() {
  size(900,900);
  background(255);
  b = new Board();
  bag = new ArrayList<Tetrimino>();
  generateBag();
  current = bag.get(0);
}
