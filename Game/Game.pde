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
int displayTime = 10;
int lastClear = 0;
int prevLines = 0;
String lastSpin = "";
int timeSinceLastClear = 0;

int mode = 0;
ArrayList<Integer> topscores = new ArrayList<>(Arrays.asList(1000, 2000, 3000, 4000, 5000));

int SPAWNX = 410;
int SPAWNY = 50;

ArrayList<Tetrimino> bag;
final List<Float> speed = Arrays.asList(0.016667, 0.021017, 0.026977, 0.035256, 0.04693, 0.06361, 0.0879, 0.1236, 0.1775, 0.2598, 0.388, 0.59, 0.92, 1.46, 2.36);

boolean canHold;
Tetrimino hold;

Tetrimino current;
Board b;

int framesSinceInput = 0;
int framesUntilLock = 60;

void dtCannon() {  //hardcodes opening pieces
  bag.add(new Tetrimino(SPAWNX, SPAWNY, JPIECE));
  bag.add(new Tetrimino(SPAWNX, SPAWNY, LPIECE));
  bag.add(new Tetrimino(SPAWNX, SPAWNY, IPIECE));
  bag.add(new Tetrimino(SPAWNX, SPAWNY, OPIECE));
  bag.add(new Tetrimino(SPAWNX, SPAWNY, ZPIECE));
  bag.add(new Tetrimino(SPAWNX, SPAWNY, SPIECE));
  bag.add(new Tetrimino(SPAWNX, SPAWNY, TPIECE));
}

void generateBag() {
  ArrayList<Tetrimino> temp = new ArrayList<Tetrimino>();
  temp.add(new Tetrimino(SPAWNX, SPAWNY, IPIECE));
  temp.add(new Tetrimino(SPAWNX, SPAWNY, JPIECE));
  temp.add(new Tetrimino(SPAWNX, SPAWNY, LPIECE));
  temp.add(new Tetrimino(SPAWNX, SPAWNY, OPIECE));
  temp.add(new Tetrimino(SPAWNX, SPAWNY, TPIECE));
  temp.add(new Tetrimino(SPAWNX, SPAWNY, ZPIECE));
  temp.add(new Tetrimino(SPAWNX, SPAWNY, SPIECE));
  Collections.shuffle(temp);
  bag.addAll(temp);
}

void tick() {
  if (frameCount % int(1 / speed.get(level - 1)) == 0) {
    if (!current.leftrightCollision(b.board, 0, 1)) { //if no collision down, move down
      framesUntilLock = int(1 / speed.get(level - 1)) * 3;
      current.down();
    }
    else if (framesSinceInput <= 10 && framesUntilLock > 0) { //if there was a recent input and it hasn't been stuck for too long, delay for a while
      framesUntilLock -= int(1 / speed.get(level - 1));
    }
    else{
      lockPiece();}
  }
}

void lockPiece() {
  for (PVector p : current.blocks) {
    if (current.getRowNum(p) < 0) endGame();
    else b.board[current.getRowNum(p)][current.getColNum(p)] = current.pieceColor;
  }
  lastSpin = current.lastSpin;
  bag.remove(0);
  current = bag.get(0);
  frameCount = 0;
  updateBag();
  prevLines = lines;
  int linescleared = b.updateBoard();
  
  lines += linescleared;
  score += calculateScore(linescleared);
  if(linescleared != 0 && (prevLines % 10) + linescleared >= 10 && level < 15){
    level++;
  }
  canHold = true;
  
  //print(linescleared + "lock");
  if (linescleared != 0) {
    timeSinceLastClear = 0;
    lastClear = linescleared;
  }
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
  
  if(mode == 1){
    Tetrimino temp = bag.get(1);
    temp.displayatpos(750, 210);
    
    temp = bag.get(2);
    temp.displayatpos(750, 345);
    
    temp = bag.get(3);
    temp.displayatpos(750, 480);
  }
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
    hold = new Tetrimino(410, 130, current.piecetype);
    bag.remove(0);
    current = bag.get(0);
    canHold = false;
  }
  else {
    if (canHold) {
      Tetrimino temp = hold;
      hold = new Tetrimino(410, 130, current.piecetype);
      current = temp;
      current = new Tetrimino(SPAWNX, SPAWNY, current.piecetype);
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

int calculateScore(int clear){
  int points = 0;
  if(clear == 0){
    return 0;
  }
  
  if(clear == 1){
    points = 100 * level;
  }
  
  if(clear == 2){
    points = 300 * level;
  }
  
  if(clear == 3){
    points = 500 * level;
  }
  
  if(clear == 4){
    points = 800 * level;
  }
  
  return points;

}

void displayClear(int linescleared){
  int currentFrame = frameCount;
   while(frameCount - currentFrame < displayTime){
    fill(255);
    textSize(30);
    if(linescleared == 1){
      text("SINGLE!", 400, 400);
    }
    else if(linescleared == 2){
      text("DOUBLE!", 400, 400);
    }
    else if(linescleared == 3){
      text("TRIPLE!", 400, 400);
    }
    else{
      text("TETRIS!", 400, 400);
    }
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
    rect(246, 50, 406, 801);
    
    fill(0, 50, 240);
    strokeWeight(10);
    stroke(0, 70, 240);
    rect(330, 85, 245, 90);
    rect(411, 175, 82, 80);
    strokeWeight(0);
    rect(417, 165, 72, 20);
    
    textSize(70);
    fill(255, 0, 255);
    text("T", 340, 150);
    
    fill(255, 120, 0);
    text("E", 380, 150);
    
    fill(255, 255, 0);
    text("T", 420, 150);
    
    fill(0, 255, 0);
    text("R", 460, 150);
    
    fill(0, 191, 255);
    text("I", 505, 150);
    
    fill(200, 0, 200);
    text("S", 530, 150);
    
    strokeWeight(2);
    stroke(255);
    fill(0, 255, 0); //green
    rect(350, 315, 200, 65); //play button
    
    fill(255);
    textSize(30);
    text("PLAY", 420, 355); //text for play button
    
    fill(150);
    rect(360, 405, 180, 55); //level button
    strokeWeight(0);
    
    fill(255);
    textSize(25);
    text("LEVEL: " + level, 407, 440); //dynamic level change text
    
    
    //display scores
    
    fill(0);
    strokeWeight(2);
    stroke(255);
    rect(300, 520, 300, 225);
    
    textSize(30);
    fill(255);
    text("HIGH SCORES", 365, 560);
    
    for(int i = 0; i < 5; i++){
      textSize(25);
      text(topscores.get(4 - i), 520, 610 + i * 30);
    }
  }

  else if (mode == 1) {
    current.display();
    tick();
    if(lastClear > 0 && timeSinceLastClear < 50){
      if((prevLines % 10) + lastClear >= 10 && level < 15){
        fill(255);
        textSize(30);
        text("LEVEL UP!", 385, 300);
      }
      timeSinceLastClear++;
      fill(255);
      textSize(30);
      if(lastClear == 1){
        text(lastSpin + "Single!", 400, 400);    
      }
      else if(lastClear == 2){
        text(lastSpin + "Double!", 400, 400);
      }
      else if(lastClear == 3){
        text(lastSpin + "Triple!", 400, 400);
      }
      else{
        text("TETRIS!", 400, 400);
      }
    }
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
    rect(200, 100, 550, 500);
    
    //high score box
    fill(0);
    strokeWeight(2);
    stroke(255);
    rect(325, 280, 300, 175);
    
    //home button
    fill(100);
    strokeWeight(2);
    stroke(255);
    rect(250, 500, 140, 50);
    
    //play again button
    fill(0, 255, 0);
    strokeWeight(2);
    stroke(255);
    rect(400, 500, 140, 50);
    
    //end button
    fill(255, 0, 0);
    strokeWeight(2);
    stroke(255);
    rect(550, 500, 140, 50);
    
    fill(255);
    textSize(45);
    text("GAME OVER", 370, 180);
    
    textSize(30);
    text("HIGH SCORES", 390, 250);
    
    textSize(20);
    text("HOME", 295, 530);
    text("PLAY AGAIN", 425, 530);
    text("EXIT", 603, 530);
    
    for(int i = 0; i < 5; i++){
      textSize(25);
      text(topscores.get(4 - i), 550, 315 + i * 30);
    }
    
    
    
  }
}

void mouseClicked(){
  if(mode == 0){
    if((mouseX < 550 && mouseX > 350) && (mouseY < 380 && mouseY > 315)){
      mode = 1;
    }
    if((mouseX < 540 && mouseX > 360) && (mouseY < 460 && mouseY > 405)){
      if(level == 10){
        level = 0;
      }
      level++;
    }
  }
  
  if(mode == 2){
    if(mouseY < 550 && mouseY > 500){
      if(mouseX < 390 && mouseX > 250){
        mode = 0;
        b = new Board();
        bag = new ArrayList<Tetrimino>();
        generateBag();
        current = bag.get(0);
        hold = null;
      }
      else if(mouseX < 540 && mouseX > 400){
        mode = 1;
        b = new Board();
        bag = new ArrayList<Tetrimino>();
        generateBag();
        current = bag.get(0);
        hold = null;
      }
      else{
        exit();
      }
    }

  }
}

void setup() {
  size(950,900);
  background(255);
  b = new Board();
  bag = new ArrayList<Tetrimino>();
  //dtCannon();
  generateBag();
  current = bag.get(0);
}
