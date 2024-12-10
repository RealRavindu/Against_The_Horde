class Tiles{
 PVector coordinates;
 int ID;
 int tileNumber;
 boolean playable;
 boolean bearsZombie;
 boolean bearsNextMove;
  
  Tiles(int tempX, int tempY, int tempID, int tempTN){
   coordinates = new PVector(tempX,tempY);
   ID = tempID;
   tileNumber = tempTN;
 }
 
 void display(){
   if(ID==0){ //playable tile
    fill(150);
    rect(coordinates.x,coordinates.y,20,20);
   }
   if(ID==1){ //danger tile
    fill(255,0,0);
    rect(coordinates.x,coordinates.y,20,20);
   }
   if(ID==2){ //unplayable tile
    fill(30);
    rect(coordinates.x,coordinates.y,20,20);
   }
   if(ID ==3) { //player tile
     fill(0,0,255);
     circle(coordinates.x, coordinates.y+1,14);
     rect(coordinates.x, coordinates.y-8,2,2);
   }
   if(ID==5) { //exit
    fill(150);
    rect(coordinates.x,coordinates.y,20,20);
    fill(209,110,34);
    rect(coordinates.x, coordinates.y-1, 10,18);
   }
   if(playable){ //draw a green overlay over tiles that are clickable by the player
    fill(0,255,0,50);
    rect(coordinates.x,coordinates.y,20,20);
   }
 }
  
  boolean isMouseHovering(){
   if(mouseX>coordinates.x-10 && mouseX<coordinates.x+10 && mouseY>coordinates.y-10 && mouseY<coordinates.y+10){
    return true; 
   } else {
     return false;
   }
  }
}
