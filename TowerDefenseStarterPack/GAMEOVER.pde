//This function draws the GAMEOVER screen.

void gameOver() {
  background(nBlue, 10);
  
  fill(mGold);
  textSize(64);
  text("GAMEOVER",width/2, 250);
  textSize(18);
  text("You survived " + (waveCount-1) + " waves", width/2, 400);
  
  restart.show();
  if (restart.buttonClicked()) {
    mode = INTRO;
    statInitialize();
    
    //reset the objects
    arrayListInitalize();
  }
}
