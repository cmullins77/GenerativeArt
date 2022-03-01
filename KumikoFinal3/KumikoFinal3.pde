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
int endFrame = 20;

int num = 0;
int currNum = 0;

boolean isRenderingVideo = true;
boolean showStart = true;

boolean useWood = true;
boolean useRandomStart = true;
boolean animatedSky = false;

void setup() {
  woodImg = loadImage("wood3.jpg");
  
  fill(useWood ? 0 : 255);
  
  readRuleFile();
  size(1080,1080);
  automataSetup();
  num = cols*3;
}

void draw() {
  background(useWood ? 0 : 255);
  drawTriangles(true);
  if (frame == num) {
    save("Kumiko" + currNum + ".jpg"); 
    if (currNum >= endFrame) {
      noLoop(); 
    }
    automataSetup(); 
    num += cols*3;
    currNum++;
  }
  frame++;
}

float rand(float min, float max, float scale) {
  float t = pow(random(0,1), scale);
  return (1-t)*min + t*max;
}
