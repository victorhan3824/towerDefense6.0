//This function draws the BUILD screen

void build() {
  animateEverything(); /*animate things
  source is in PLAY tab
  */
  buildBar();
  if (clickable) buildModeButtonControl();
  aesthetics();
}

void buildBar() {
  //bar itself
  fill(purple);
  noStroke();
  rect(width/2, 570, width, 60);

  toPlay.show(); //go to PLAY mode button show
  buildT1.show();
  buildT2.show();
  buildT3.show();
  
  //draw description box
  stroke(violet);
  fill(nBlue);
  rect(595, 570, 210, 55);
  fill(mGold);
  textSize(16);
  if (buildT1.isHover()) {
    text(towerDescriptions[0], 595, 560);
    text(towerDescriptions[1], 595, 580);
  }
  if (buildT2.isHover()) {
    text(towerDescriptions[2], 595, 560);
    text(towerDescriptions[3], 595, 580);
  }
  if (buildT3.isHover()) {
    text(towerDescriptions[4], 595, 560);
    text(towerDescriptions[5], 595, 580);
  }
}

void buildModeButtonControl() {
  //go to PLAY mode
  if (toPlay.buttonClicked()) {
    mode = PLAY;
  }
  
  //placing towers
  if (buildT1.buttonClicked() && money >= 8) {
    towers.add(new Tower(GUN));
  }
  if (buildT2.buttonClicked() && money >= 12) {
    towers.add(new Tower(SNP)); 
  }
  
  if (buildT3.buttonClicked() && money >= 15) {
    towers.add(new Tower(GAL)); 
  }
  
}

void aesthetics() {
  //wave count
  textSize(18);
  stroke(violet);
  fill(nBlue);
  rect(width/2, 40, 240, 40);
  fill(mGold);
  text("Build Mode", width/2, 40);  
}
