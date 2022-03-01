int rows, cols;
int numPatterns, totalPatterns, chosenRuleSet;

IntList pList;

PImage woodImg;

float triangleSize, w;

int[][] colors;

int[] ruleSet;
int[][] ruleOptions;

int frame = 0;
int framesPerSection, framerate;
int endFrame = 2400;

boolean isRenderingVideo = true;
boolean showStart = true;

boolean useWood = true;
boolean useRandomStart = false;
boolean animatedSky = false;

void setup() {
  woodImg = loadImage("wood3.jpg");
  
  fill(useWood ? 0 : 255);
  
  readRuleFile();
  size(1920,700);
  automataSetup();
  
}

void draw() {

  if (isRenderingVideo) {
    save("Kumiko" + frame + ".jpg"); 
  }
  frame++;
  if (frame % framerate == 0 || animatedSky) {
    background(useWood ? 0 : 255);
    drawTriangles(frame % framerate == 0); 
  } else {
    
  }
  if (frame >= endFrame) {
    noLoop(); 
  }
  else if (frame % framesPerSection == 0) {
    automataSetup(); 
  }
}

float rand(float min, float max, float scale) {
  float t = pow(random(0,1), scale);
  return (1-t)*min + t*max;
}
