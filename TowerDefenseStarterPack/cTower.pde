//A Tower is the player's main defense against the mobs.
//Towers are placed on the maps and then automatically
//act. There are 3 kinds of towers (but you can make more!)

//Gun Tower: These towers shoot bullets that fly across
//           the screen and do damage to mobs.

//AoE Tower: These towers place AoE_Rings that deal damage
//           to all mobs in the ring.

//Sniper Tower: These towers automatically target the first
//              mob no matter where they are on the scren.

class Tower {
  final int PLACING = 0; //this mode is when we are selcting locations, 
                         //tower follows the mouse
  final int PLACED = 1; //this mode means tower is in place
  
  float x, y;
  int charge, threshold;
  int status; //sets the placing status
  int type; //determine the type of tower
  int price;
  
  Tower(int T) {
    x = mouseX;
    y = mouseY;
    status = PLACING;
    type = T;
    charge = 0;
    
    if (this.type == GUN) {
      threshold = 60 + mapNum*20;
      price = 8;
    }  
    
    if (this.type == SNP) {
      threshold = 120 + 60*mapNum;
      price = 12;
    }
    
    if (this.type == GAL) {
      threshold = 60 + mapNum*40;
      price = 15;
    }
  }
//=================================================== 
  void show() {
    stroke(black);
    strokeWeight(4);
    fill(nBlue);
    animatingTower();
  }
  
  void act() {
    if (type == GUN) actGUN();
    if (type == SNP) actSNP();
    if (type == GAL) actGAL();
  }
  
//===================================================
  void animatingTower() {
    if (status == PLACED) {
      imageTowersDisplay(x,y);
    } else if (status == PLACING) {
      clickable = false;
      //drawing placement restriction ------
      stroke(red);
      noFill();
      rect(325,217.5+75,650,435);
      drawOutRestrictions();
      //--------------------------
      imageTowersDisplay(mouseX, mouseY); //towers follow mouse
      
      if (type == GUN) drawRange(125);
      else if (type == GAL) drawRange(75);
      
      drawInnerRing(); 
      displayQkeyLogo();
      if (mousePressed && allowPlace() && !onTop()) { //when user have click on desired location
        status = PLACED;
        clickable = true;
        x = mouseX;
        y = mouseY;
        money = money - this.price;
        //add into list of coords
        coords.add(x);
        coords.add(y);
      }//----------------------------------------------
      if (qKey) {
        towers.remove(this); //remove when press Q
        clickable = true; //make sure user can click on buttons once again
      }    
    }
  }

//=====================================================  
  void drawOutRestrictions() {
    //this draw out the tower restrictions
    for (int i=0; i < coords.size(); i += 2) {
      stroke(red);
      noFill();
      circle(coords.get(i), coords.get(i+1), 75);
    }
  }
  
  void displayQkeyLogo() {
    //display the Q key and its instructions
    noStroke();
    fill(nBlue);
    rect(35, 40, 43, 43, 5);
    fill(violet);
    rect(35, 40, 38, 39, 5);
    fill(nBlue);
    rect(35, 40, 30, 30, 5);
    fill(mGold);
    textSize(32);
    text("Q", 35, 35);
    textSize(18);
    fill(violet);
    text("Cancel Build", 100, 35);
  }
  
  void drawRange(float R) {
    stroke(200,0,0,75);
    fill(255,0,0,50);
    circle(mouseX, mouseY, 2*R); //mouse coords because this is when tower follows mouse while placing
  }
  
  void drawInnerRing() {
    stroke(0,255,0);
    noFill();
    circle(mouseX, mouseY, 75);
  }
  
  boolean allowPlace() {
    return(mouseX > 0 && mouseX < 650 && mouseY > 75 && mouseY < 510);  //restrict top right
  }
  
  boolean onTop() { //check if tower is ontop another one
    for (int i=0; i<coords.size(); i+=2) {
      if (dist(mouseX, mouseY, coords.get(i), coords.get(i+1)) < 75) { 
        return true;
      }
    }
    return false;
  }
  
  void imageTowersDisplay(float X, float Y) {
    image(towerImages[type], X, Y);
  }
  
  void actGUN() { //fire bullets and calculate cooldown
    charge++; 
    if (charge >= threshold) { //when charge reach the threshold
      charge = 0;
      shells.add(new Bullet(GUN, this.x, this.y, 10, 0)); //right
      shells.add(new Bullet(GUN, this.x, this.y, -10, 0)); //left
      
      for (int i=-1; i< 2; i ++) {
        shells.add(new Bullet(GUN, this.x+i*10, this.y, 0, 10)); //up
        shells.add(new Bullet(GUN, this.x+i*10, this.y, 0, -10)); //down
      }
    }      
  }
  
  void actSNP() { //sniper tower act
    if (parsas.size() > 0) {
      color filled = black;
      if (charge < threshold) {
        filled = black;
      }
      else if (charge == threshold) {
        parsas.get(0).hp --;
      }
      else if (charge > threshold) {
        filled = white;
        if (charge >= threshold + 10) charge = 0;
      }
      charge++;
      
      strokeWeight(map(charge,0, 120+mapNum*60, 1, 3));
      stroke(filled);
      line(x,y,parsas.get(0).x,parsas.get(0).y);      
    }
  }
  
  void actGAL() {
    charge++; 
    if (charge >= threshold) { //when charge reach the threshold
      charge = 0;
      shells.add(new Bullet(GAL, this.x, this.y));
    }
  }  
  
}  
