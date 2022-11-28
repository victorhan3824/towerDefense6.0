//Tower Defense Game
//YOUR NAME GOES HERE
//Programming 12

// ================ GLOBAL VARIABLES =================

final int INTRO    = 0;
final int PLAY     = 1;
final int BUILD    = 2;
final int GAMEOVER = 3;
final int INTRO2   = 4;
int mode;

final int GUN = 0;
final int SNP = 1;
final int GAL = 2;

final int REG = 0;
final int SPD = 1;
final int CNK = 2;

//Pallette
color white  = #ffffff;
color black  = #221E22;
color violet = #44355B;
color purple = #31263E;
color mGold  = #ECA72C; //marigold
color flame  = #EE5622;
color nBlue  = #1B3A86; //navy blue
color gray   = #959594;
color red    = #F70505;

//Mouse & Keyboard interaction variables
boolean mouseReleased;
boolean wasPressed;
boolean clickable; //check whether you can click

//Buttons
Button map1B, nWave, toBuild, toPlay, map2B;
Button buildT1, buildT2, buildT3;
Button restart;

//Collections of objects
Node[] nodes;
ArrayList <Mob> parsas;
ArrayList <Tower> towers;
ArrayList <Bullet> shells;
ArrayList <Float> coords;

//Images and Gifs and Fonts
Gif introG;
PImage backdrop, next, flagship, treasure, material;
PFont font;

PImage carrack, frigate, galleon;
PImage[] towerImages;

PImage regM, chunkM, speedM;
//game stats
int waveCount, health, maxHealth, money; 
int transitionCount;
int mapNum;

String[] towerDescriptions = {"Powerful 16th century", "Portugese gun ship ($8)", 
                              "Accurate warships with great", "range but slow firing rate ($10)",
                              "Powerful area damage ships", "from the Spanish Armada ($15)"};
                              
boolean qKey; //press keyboard check

// ===================== SETUP =========================

void initializeModes() {
  //set up the default mode for things
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  mode = INTRO;
}

void initializeVariables() {
  //Load Images & Gifs
  introG = new Gif("introGif/frames (", ").gif",50,1,width/2,height/2,width,height);
  backdrop = loadImage("seamap.jpg");
  next     = loadImage("next.png");
  flagship = loadImage("homeship.png");
  treasure = loadImage("treasure.png");
  material = loadImage("nails.png");
  carrack = loadImage("carrack.png");
  frigate = loadImage("frigate.png");
  galleon = loadImage("galleon.png");
  
  towerImages = new PImage[3];
  towerImages[0] = carrack;
  towerImages[1] = frigate;
  towerImages[2] = galleon;
   
  regM = loadImage("reg.png");
  chunkM = loadImage("chunk.png");
  speedM = loadImage("speed.png");
  
  resizing();
  //Load Fonts
  font = createFont("Miss Queen.ttf",24);
  
  arrayListInitalize();
}

void arrayListInitalize() {
  //Create Collections of Objects
  parsas = new ArrayList<Mob>();  
  towers = new ArrayList<Tower>();
  shells = new ArrayList<Bullet>();
  coords = new ArrayList<Float>();    
}

void resizing() {
  //used to resize to reduce lag, only for non-object images
  backdrop.resize(width,height);
  flagship.resize(100,100);
  material.resize(60,60);
  treasure.resize(60,60);
  
  carrack.resize(60,60);
  frigate.resize(60,60);
  galleon.resize(60,60);
}

void makeButtons() {
  //INTRO - Start
  map1B = new Button(0, width*0.85, 8*height/10, 200, 50, 5,0, mGold, nBlue, violet ,"Cross the Atlantic");
  map2B = new Button(0, width*0.85, 9*height/10, 200, 50, 5,0, mGold, nBlue, violet ,"From the new World");

  //PLAY - Next Wave, To Build Mode
  nWave = new Button(1, 750, 570, 70, 55, 5, purple, next); //next wave button
  toBuild = new Button(0, 650, 570, 80, 55, 5, 0, mGold, nBlue ,violet, "BUILD");//go to BUILD
  
  //BUILD - To play mode, Buy Sniper, Buy Gun, Buy AoE
  toPlay = new Button(0, 750, 570, 80, 55, 5, 0, mGold, nBlue ,violet, "PLAY");//BUILD --> PLAY
  buildT1 = new Button(0, 85, 570, 150, 55, 5, 0, mGold, nBlue ,violet, "CARRACK");
  buildT2 = new Button(0, 245, 570, 150, 55, 5, 0, mGold, nBlue ,violet, "FRIGATE");
  buildT3 = new Button(0, 405, 570, 150, 55, 5, 0, mGold, nBlue ,violet, "GALLEON");
  
  //GAMEOVER - Reset
  restart = new Button(0, width*0.85, 9*height/10, 200, 50, 5,0, mGold, nBlue, violet ,"Play Again");
  
}

void statInitialize() {
  transitionCount = 0;
  waveCount = 1;  
  maxHealth = 5;
  health    = maxHealth;
  money     = 20;
  mapNum = 0; //this determine map, will be changed in intro
}

void setup() {
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  size(800, 600);
  initializeModes();
  initializeVariables();
  makeButtons();
  statInitialize();
  clickable = true;
}

// ===================== DRAW ===========================

void draw() {
  textFont(font);
  if (mode == INTRO) {
    intro();
  } else if (mode == INTRO2) {
    rectMode(CORNER);
    midIntro();  
  } else if (mode == PLAY) {
    rectMode(CENTER);
    play();
  } else if (mode == BUILD) {
    build();
  } else if (mode == GAMEOVER) {
    gameOver();
  }
}
