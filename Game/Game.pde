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
final int BOARD_START_X = 250;
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
  temp.add(new Tetrimino(410, 130, IPIECE));
  temp.add(new Tetrimino(410, 130, JPIECE));
  temp.add(new Tetrimino(410, 130, LPIECE));
  temp.add(new Tetrimino(410, 130, OPIECE));
  temp.add(new Tetrimino(410, 130, TPIECE));
  temp.add(new Tetrimino(410, 130, ZPIECE));
  temp.add(new Tetrimino(410, 130, SPIECE));
  Collections.shuffle(temp);
  bag.addAll(temp);
}

void tick() {
  if (frameCount % int(1 / speed.get(level - 1)) == 0) {
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
  int prevlines = lines;
  int linescleared = b.updateBoard();
  lines += linescleared;
  print(lines);
  calculateScore(linescleared);
  if(linescleared != 0 && (prevlines % 10) + linescleared > 10){
    print("If statement run");
    level++;
  }
  canHold = true;
}

void updateBag(){
  if(bag.size() <= 5){
    generateBag();
  }
}

void displayBag() {
  fill(100);
  strokeWeight(10);
  stroke(200);
  rect(670,100, 240, 500);
  
  fill(255);
  textSize(20);
  text("NEXT", 770, 130);
  
  fill(0);
  strokeWeight(0);
  rect(685, 140, 210, 440);
  
  Tetrimino temp = bag.get(1);
  temp.displayatpos(750, 210);
  
  temp = bag.get(2);
  temp.displayatpos(750, 345);
  
  temp = bag.get(3);
  temp.displayatpos(750, 480);
  
}
  
void displayHold() {
  fill(100);
  strokeWeight(10);
  stroke(200);
  rect(30,100, 200, 195);
  fill(255);
  textSize(20);
  text("HOLD", 105, 125);
  
  fill(0);
  strokeWeight(0);
  rect(40, 140, 180, 140);
  
  if(hold != null){
    hold.displayatpos(90, 195);
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
  fill(100);
  strokeWeight(10);
  stroke(200);
  rect(30, 500, 200, 320); 
   
  fill(0);
  strokeWeight(0);
  rect(50, 545, 160, 50);
  
  fill(255);
  textSize(20);
  text("SCORE", 105, 535);
  textSize(30);
  text(score, 105, 575);
  
  fill(0);
  strokeWeight(0);
  rect(50, 655, 160, 50);
  
  fill(255);
  textSize(20);
  text("LEVEL", 105, 645);
  textSize(30);
  text(level, 105, 685);
  
  fill(0);
  strokeWeight(0);
  rect(50, 760, 160, 50); 
  
  fill(255);
  textSize(20);
  text("LINES", 105, 750);
  textSize(30);
  text(lines, 105, 790);
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
  size(950,900);
  background(255);
  b = new Board();
  bag = new ArrayList<Tetrimino>();
  generateBag();
  current = bag.get(0);
}
