ArrayList<Tetrimino> bag;
int score;
Tetrimino hold;
boolean canHold;

void generateBag() {
  ArrayList<Tetrimino> group = new ArrayList<Tetrimino>();
  
  // need new constructors
  //group.add(new iPiece());
  //group.add(new jPiece());
  //group.add(new lPiece());
  //group.add(new oPiece());
  //group.add(new sPiece());
  //group.add(new tPiece());
  //group.add(new zPiece());
  //Collections.shuffle(group);
  //for (int i = 0; i < 7; i++) {
  //  bag.add(group.get(i));
  //}
}
  

void displayBag() {
  fill(0);
  strokeWeight(10);
  stroke(127);
  rect(620,175, 100, 250);
}
  
void displayHold() {
  fill(0);
  strokeWeight(10);
  stroke(127);
  rect(80,175, 100, 100);
}
  
void displayScore() {
  fill(0);
  strokeWeight(10);
  stroke(127);
  rect(80, 500, 100, 200); 
}

void setup() {
  size(800,900);
  background(255);
  Board board = new Board();
  board.displayBoard();
  displayBag();
  displayHold();
  displayScore();
}
