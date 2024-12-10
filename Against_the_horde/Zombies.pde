class Zombies {
  PVector coordinates;
  int zombieTN;
  int moveDir;
  int lookDir = 2;
  int predictedTN;
  boolean isAggroed;
  ArrayList<Integer> movableTiles;
  
 Zombies(int tempX, int tempY, int tempTN){
   coordinates = new PVector(tempX, tempY);
   zombieTN = tempTN;
   println("zombie just got created, tile no: " + zombieTN);
 }
 
 void display(){
  fill(0,255,40);
  if(lookDir ==0){
    circle(coordinates.x, coordinates.y+1,14);
    rect(coordinates.x, coordinates.y-8, 2,2);
  }
  if(lookDir ==1){
    circle(coordinates.x-1, coordinates.y,14);
    rect(coordinates.x+8, coordinates.y, 2,2);
  }
  if(lookDir ==2){
    circle(coordinates.x, coordinates.y-1, 14);
    rect(coordinates.x, coordinates.y+8, 2,2);
  }
  if(lookDir ==3){
    circle(coordinates.x-1, coordinates.y,14);
    rect(coordinates.x-8, coordinates.y, 2,2);
  }
 }
 void chooseDirection(){
   if(movableTiles.size() >0){
   moveDir = movableTiles.get(int(random(0,movableTiles.size()-1)));
   if(moveDir ==0){
     tileList.get(zombieTN-20).bearsNextMove = true;
     predictedTN = tileList.get(zombieTN-20).tileNumber;
   }
   if(moveDir ==1){
     tileList.get(zombieTN+1).bearsNextMove = true;
     predictedTN = tileList.get(zombieTN+1).tileNumber;
   }
   if(moveDir ==2){
     tileList.get(zombieTN+20).bearsNextMove = true;
     predictedTN = tileList.get(zombieTN+20).tileNumber;
   }
   if(moveDir ==3){
     tileList.get(zombieTN-1).bearsNextMove = true;
     predictedTN = tileList.get(zombieTN-1).tileNumber;
   }
   } else {
    predictedTN = zombieTN; 
   }
   println("available directions: " + movableTiles);
   println("chosen direction: " + moveDir);
 }
 //chooses a direction and checks if the zombo CAN actually move there, if can't re-choose a direction
 void checkMovableTiles() {
   movableTiles = new ArrayList<Integer>();
   println("Checking tiles for zombie at TN: " + zombieTN);
   if(zombieTN>19){
     if((tileList.get(zombieTN-20).ID ==0  || tileList.get(zombieTN-20).ID ==3 || tileList.get(zombieTN-20).ID ==1) && tileList.get(zombieTN-20).bearsZombie == false && tileList.get(zombieTN-20).bearsNextMove == false){
       println("up considered");
      movableTiles.add(0); //up
     }
   }
     if((tileList.get(zombieTN+1).ID ==0 || tileList.get(zombieTN+1).ID ==3 || tileList.get(zombieTN+1).ID ==1) && tileList.get(zombieTN+1).bearsZombie == false && tileList.get(zombieTN+1).bearsNextMove == false){
      movableTiles.add(1); //right
      println("right considered");
     }
     if(zombieTN < 369) {
     if((tileList.get(zombieTN+20).ID ==0 || tileList.get(zombieTN+20).ID ==3 || tileList.get(zombieTN+20).ID ==1) && tileList.get(zombieTN+20).bearsZombie == false && tileList.get(zombieTN+20).bearsNextMove == false){
      movableTiles.add(2); //down
      println("down considered");
     }
     }
     if((tileList.get(zombieTN-1).ID ==0 || tileList.get(zombieTN-1).ID ==3 || tileList.get(zombieTN-1).ID ==1) && tileList.get(zombieTN-1).bearsZombie == false && tileList.get(zombieTN-1).bearsNextMove == false){
      movableTiles.add(3); //left
      println("left considered");
     }
    chooseDirection();
 }
 //Draw the chosen movement out for the player to see
 void predictMovement(){
    noFill();
   if(moveDir == 0){
     display();
    line(coordinates.x,coordinates.y, coordinates.x, coordinates.y-19);
   }
   if(moveDir == 1){
     display();
    line(coordinates.x+19,coordinates.y, coordinates.x, coordinates.y);
   }
   if(moveDir == 2){
     display();
    line(coordinates.x,coordinates.y, coordinates.x, coordinates.y+20);
   }
   if(moveDir == 3){
     display();
    line(coordinates.x-19,coordinates.y, coordinates.x, coordinates.y);
   }
   
 }
 
 void move(){
   coordinates = new PVector(tileList.get(predictedTN).coordinates.x, tileList.get(predictedTN).coordinates.y);
   lookDir = moveDir;
   movableTiles = new ArrayList<Integer>();
   checkMovableTiles();
 }
  
}
