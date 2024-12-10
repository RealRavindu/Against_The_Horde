Tiles t;
Zombies z;
int assignTileID;
int playerTN;
int exitTN;
ArrayList<Tiles> tileList = new ArrayList<Tiles>();
ArrayList<Tiles> alarmList = new ArrayList<Tiles>();
ArrayList<Zombies> zombieList = new ArrayList<Zombies>();

void setup() {
 size(400,400); 
 rectMode(CENTER);
 levelGeneration();
 spawnPlayer();
 spawnExit();
 spawnZombies();
 drawZombieMovement();
}

void draw(){
  for (Tiles t : tileList){
   t.display();
   highlightPlayable();
  }
  for (Zombies z : zombieList) {
   z.display();
   z.predictMovement();
  }
}

void levelGeneration(){
  int TN =0;
  //generating 400 tiles of type 1 or 2
 for(int y=10; y<400; y+=20){
  for(int x=10; x<400; x+=20){
   
   t = new Tiles(x,y,0, TN); 
   tileList.add(t);
    TN++;
  }
 }
 //going through and generating the borders on either side.
 for(Tiles t : tileList){
   if(t.coordinates.x<60){
     if(t.coordinates.x<40){
       if(t.coordinates.x<20){
     t.ID = 2; //making the very left edge unplayable all through
   }
   
   if((random(0,10))>5){ //50% chance of the square being unplayable on the second column
     t.ID =2; 
   }
   }
   //Checking if the tile before the current one is unplayable to then roll a 20% check to make it unplayable.
   //We check if the tile before it is also unplayable so that there aren't any disjointed unplayable tiles.
   if(t.tileNumber >0){
     if(tileList.get(t.tileNumber-1).ID == 2) {
       if((random(0,10))>8){
     t.ID =2; 
   }
     }
   }
   }
   if(t.coordinates.x>380){
     t.ID = 2;
   }
   if(t.coordinates.x>360 && t.coordinates.x<380){
       if((random(0,10))>5){
         t.ID =2;
       }
     }
 }
 //iterating through list again to add 3rd layer of unplayable blocks to the right side
 for(Tiles t:tileList){
   if(t.coordinates.x>340 && t.coordinates.x<360){
     if(t.tileNumber <399){
       if(tileList.get(t.tileNumber+1).ID == 2) {
         if((random(0,10))>8){
            t.ID =2; 
         }
       }
     }
   } 
 }
 //spawning alarm/glass tiles
 for(int n=0; n<40; n++){
  int tempTN = getRandomTile();
  if(tileList.get(tempTN).ID == 0 && tileList.get(tempTN).playable != true){
    tileList.get(tempTN).ID = 1;
    alarmList.add(tileList.get(tempTN));
  }
 }
}

void spawnZombies(){
 //spawning zombies
 for(int n=0; n<40; n++){
  int tempTN = getRandomTile();
  if(tileList.get(tempTN).ID == 0 && tileList.get(tempTN).playable == false && tileList.get(tempTN).bearsZombie == false){
    z = new Zombies(int(tileList.get(tempTN).coordinates.x), int(tileList.get(tempTN).coordinates.y), tempTN);
    zombieList.add(z);
    tileList.get(tempTN).bearsZombie = true;
    println("no: " + n +" |zombie coords: " + zombieList.get(n).coordinates.x + ", " + zombieList.get(n).coordinates.y + " |tile ID: " + tileList.get(tempTN).ID + " |playable: " +tileList.get(tempTN).playable + " |bears zombies: " + tileList.get(tempTN).bearsZombie + " |tile number: " + tempTN );
  } else {
    n--;
 }
 }
}

void drawZombieMovement(){
 for(Zombies z:zombieList){
  z.checkMovableTiles();
 }
}
//converts the 390th tile to the player tile
void spawnPlayer(){
 tileList.get(390).ID = 3;
 playerTN = 390;
 for(Tiles t:tileList){
  if(t.tileNumber >=playerTN -21 && t.tileNumber <= playerTN +21 && t.coordinates.x <= tileList.get(playerTN).coordinates.x +20 && t.coordinates.x >= tileList.get(playerTN).coordinates.x -20 && t.ID != 2) {
   t.playable = true; 
  } else {
    t.playable = false;
 }
 }
 }
 void spawnExit(){
  tileList.get(10).ID = 5;
  exitTN = 10;
 }
//using tile numbers to select all tiles starting from top left of the player to bottom left of him, then using x to select all not adjacent
void highlightPlayable(){
 for(Tiles t:tileList){
  if(t.tileNumber >=playerTN -21 && t.tileNumber <= playerTN +21 && t.coordinates.x <= tileList.get(playerTN).coordinates.x +20 && t.coordinates.x >= tileList.get(playerTN).coordinates.x -20 && t.ID != 2) {
   t.playable = true; 
  } else {
    t.playable = false;
 }
 }
}

int getRandomTile(){
 return int(random(0,400)); 
}

void mousePressed(){
 for(Tiles t:tileList){
  if(t.isMouseHovering() && t.playable){
   tileList.get(playerTN).ID = 0;
   t.ID = 3;
   playerTN = t.tileNumber;
  }
  for(Zombies z: zombieList){
   z.move(); 
  }
 }
 
 //troubleshooting
 for(Tiles t: tileList){
  if(t.isMouseHovering()){
   println("bearing zombies?: " + t.bearsZombie + " |bears next move?: " + t.bearsNextMove); 
  }
 }
}
