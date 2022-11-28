//This function draws the INTRO screen.

void intro() {
  textSize(24);
  introG.show(); //intro gif
  map1B.show(); //intro button
  map2B.show();
  if (map1B.buttonClicked()) {
    mode = INTRO2;
    mapNum = 1;
    makeNodes();
  }
  
  if (map2B.buttonClicked()) {
    mode = INTRO2;
    mapNum = 2;
    makeNodes();
  }
}  

void midIntro() {
  //transitional intro to display title
  background(nBlue);
  
  fill(mGold);
  textSize(72);
  text("Treasures of the Galleon", width/2, height/3);
  
  //loading bar
  noStroke();
  fill(gray);
  rect(150,380, 500, 20);
  fill(mGold);
  float x = map(transitionCount, 0, 50, 0, 500);
  rect(150, 380, x, 20);
  
  transitionCount ++;
  if (transitionCount >= 50) mode = PLAY;
}

void makeNodes() {
  //Plot the nodes on the map
  if (mapNum == 1) {
    nodes = new Node[9];
    
    nodes[0] = new Node(100,2*height/3,0,-1);
    nodes[1] = new Node(100,height/2,1,0);
    nodes[2] = new Node(200,height/2,0,-1);
    nodes[3] = new Node(200,height/3,1,0);
    nodes[4] = new Node(500,height/3,0,1);
    nodes[5] = new Node(500,height/2,-1,0);
    nodes[6] = new Node(350,height/2,0,1);
    nodes[7] = new Node(350, 4*height/5, 1, 0);
    nodes[8] = new Node(700, 4*height/5, 0, 0); //end node
  }
  
  else { //mapNum == 2
    nodes = new Node[11];
    nodes[0] = new Node(50, height/2, 0, -1);
    nodes[1] = new Node(50, 100, 1, 0);
    nodes[2] = new Node(250, 100, 0, 1);
    nodes[3] = new Node(250, 500, 1, 0);
    nodes[4] = new Node(350, 500, 0, -1);
    nodes[5] = new Node(350, 250, -1, 0);
    nodes[6] = new Node(150, 250, 0, 1);
    nodes[7] = new Node(150, 350, 1, 0);
    nodes[8] = new Node(500, 350, 0, -1);
    nodes[9] =  new Node(500, 250, 1, 0);
    nodes[10] = new Node(700, 250, 0, 0);
  }
}
