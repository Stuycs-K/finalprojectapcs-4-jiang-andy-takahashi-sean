import java.util.*;

final int IPIECE = 0;
final int JPIECE = 1;
final int LPIECE = 2;
final int OPIECE = 3;
final int TPIECE = 4;
final int ZPIECE = 5;
final int SPIECE = 6;
final int BLOCKSIZE = 40;
final int BOARD_START_Y = 150;
final int BOARD_START_X = 250;
final int CLOCKWISE = 0;
final int COUNTERCLOCKWISE = 1;
int lines = 0;
int score = 0;
int level = 1;

int mode = 0;
ArrayList<Integer> topscores = new ArrayList<>(Arrays.asList(1000, 2000, 3000, 4000, 5000));

int SPAWNX = 410;
int SPAWNY = 150;

ArrayList<Tetrimino> bag;
final List<Float> speed = Arrays.asList(0.016667, 0.021017, 0.026977, 0.035256, 0.04693, 0.06361, 0.0879, 0.1236, 0.1775, 0.2598, 0.388, 0.59, 0.92, 1.46, 2.36);

boolean canHold;
Tetrimino hold;

Tetrimino current;
Board b;

int framesSinceInput = 0;
int framesUntilLock = 200;

void generateBag() {
  ArrayList<Tetrimino> temp = new ArrayList<Tetrimino>();
  temp.add(new Tetrimino(SPAWNX, SPAWNY, IPIECE));
  temp.add(new Tetrimino(SPAWNX, SPAWNY, JPIECE));
  temp.add(new Tetrimino(SPAWNX, SPAWNY, LPIECE));
  temp.add(new Tetrimino(SPAWNX+BLOCKSIZE/2, SPAWNY+BLOCKSIZE/2, OPIECE));
  temp.add(new Tetrimino(SPAWNX, SPAWNY, TPIECE));
  temp.add(new Tetrimino(SPAWNX, SPAWNY, ZPIECE));
  temp.add(new Tetrimino(SPAWNX, SPAWNY, SPIECE));
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
    if (current.getRowNum(p) < 0) endGame();
    else b.board[current.getRowNum(p)][current.getColNum(p)] = current.pieceColor;
  }
  bag.remove(0);
  current = bag.get(0);
  updateBag();
  int prevlines = lines;
  int linescleared = b.updateBoard();
  lines += linescleared;
  calculateScore(linescleared);
  if(linescleared != 0 && (prevlines % 10) + linescleared >= 10){
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
  rect(670,200, 240, 500);
  
  fill(255);
  textSize(20);
  text("NEXT", 770, 230);
  
  fill(0);
  strokeWeight(0);
  rect(685, 240, 210, 440);
  
  if(mode == 1){
    Tetrimino temp = bag.get(1);
    temp.displayatpos(750, 310);
    
    temp = bag.get(2);
    temp.displayatpos(750, 445);
    
    temp = bag.get(3);
    temp.displayatpos(750, 580);
  }
}
  
void displayHold() {
  fill(100);
  strokeWeight(10);
  stroke(200);
  rect(30,200, 200, 195);
  fill(255);
  textSize(20);
  text("HOLD", 105, 225);
  
  fill(0);
  strokeWeight(0);
  rect(40, 240, 180, 140);
  
  if(hold != null){
    hold.displayatpos(90, 295);
  }
}
 
void holdPiece() {
  if (hold == null) {
    hold = new Tetrimino(410, 230, current.piecetype);
    bag.remove(0);
    current = bag.get(0);
  }
  else {
    if (canHold) {
      Tetrimino temp = hold;
      hold = new Tetrimino(410, 230, current.piecetype);
      current = temp;
      current.centerX = SPAWNX;
      current.centerY = SPAWNY;
      canHold = false;
    }
  }
}
  
void displayScore() {
  fill(100);
  strokeWeight(10);
  stroke(200);
  rect(30, 600, 200, 320); 
   
  fill(0);
  strokeWeight(0);
  rect(50, 645, 160, 50);
  
  fill(255);
  textSize(20);
  text("SCORE", 105, 635);
  textSize(30);
  text(score, 105, 675);
  
  fill(0);
  strokeWeight(0);
  rect(50, 755, 160, 50);
  
  fill(255);
  textSize(20);
  text("LEVEL", 105, 745);
  textSize(30);
  text(level, 105, 785);
  
  fill(0);
  strokeWeight(0);
  rect(50, 860, 160, 50); 
  
  fill(255);
  textSize(20);
  text("LINES", 105, 850);
  textSize(30);
  text(lines, 105, 890);
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
  if(mode == 1){
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
    if (key == 'c' || key == 'C') {
      holdPiece();
    }
  }

}

void endGame() {
  mode = 2;
}

void draw() {
  background(255);
  b.displayBoard();
  displayBag();
  displayHold();
  displayScore();
  
  if (mode == 0){
    fill(50);
    rect(246, 150, 406, 801);
    
    textSize(70);
    fill(255, 0, 255);
    text("T", 340, 250);
    
    fill(255, 120, 0);
    text("E", 380, 250);
    
    fill(255, 255, 0);
    text("T", 420, 250);
    
    fill(0, 255, 0);
    text("R", 460, 250);
    
    fill(0, 0, 255);
    text("I", 505, 250);
    
    fill(200, 0, 200);
    text("S", 530, 250);
    
    
    fill(0, 255, 0); //green
    rect(350, 350, 200, 80); //play button
    
    fill(255);
    textSize(30);
    text("PLAY", 420, 400); //text for play button
    
    fill(150);
    rect(360, 460, 180, 60); //level button
    
    fill(255);
    textSize(25);
    text("LEVEL: " + level, 410, 500); //dynamic level change text
    
    
    //display scores
  }

  else if (mode == 1) {
    current.display();
    tick();
    framesSinceInput++;
  }
  else {
    
    //add current score if applicable
    
    boolean scoreAdd = false;
    
    for(int i = 4; i >= 0 && !scoreAdd; i--){
      if(score > topscores.get(i)){
        topscores.add(i + 1, score);
        topscores.remove(0);
        scoreAdd = true;
      }
    }
    
    score = 0;
    level = 1;
    lines = 0;
    
    //implement game over screen
    
    //game over
    fill(50);
    strokeWeight(10);
    stroke(200);
    rect(200, 200, 550, 500);
    
    //high score box
    fill(0);
    strokeWeight(2);
    stroke(255);
    rect(325, 380, 300, 175);
    
    //home button
    fill(100);
    strokeWeight(2);
    stroke(255);
    rect(250, 600, 140, 50);
    
    //play again button
    fill(0, 255, 0);
    strokeWeight(2);
    stroke(255);
    rect(400, 600, 140, 50);
    
    //end button
    fill(255, 0, 0);
    strokeWeight(2);
    stroke(255);
    rect(550, 600, 140, 50);
    
    fill(255);
    textSize(45);
    text("GAME OVER", 370, 280);
    
    textSize(30);
    text("HIGH SCORES", 390, 350);
    
    textSize(20);
    text("HOME", 295, 630);
    text("PLAY AGAIN", 425, 630);
    text("EXIT", 603, 630);
    
    for(int i = 0; i < 5; i++){
      textSize(25);
      text(topscores.get(4 - i), 550, 415 + i * 30);
    }
    
    
    
  }
}

void mouseClicked(){
  if(mode == 0){
    if((mouseX < 550 && mouseX > 350) && (mouseY < 430 && mouseY > 350)){
      mode = 1;
    }
    if((mouseX < 540 && mouseX > 360) && (mouseY < 520 && mouseY > 460)){
      if(level == 10){
        level = 0;
      }
      level++;
    }
  }
}

void setup() {
  size(950,1000);
  background(255);
  b = new Board();
  bag = new ArrayList<Tetrimino>();
  generateBag();
  current = bag.get(0);
}
