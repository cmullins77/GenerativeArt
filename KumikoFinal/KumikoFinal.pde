int rows, cols;
int numPatterns, totalPatterns, chosenRuleSet;

IntList pList;

float triangleSize, w;

int[][] colors;

int[] ruleSet;
int[][] ruleOptions;

int frame = 0;
int framesPerSection, framerate;
int endFrame = 7200;

boolean isRenderingVideo = false;
boolean showStart = true;

void setup() {
  readRuleFile();
  size(800,800);
  automataSetup();
  
}

void draw() {

  if (isRenderingVideo) {
    save("Kumiko" + frame + ".jpg"); 
  }
  frame++;
  if (frame % framerate == 0) {
    background(255);
    drawTriangles(); 
  }
  if (frame % framesPerSection == 0) {
    if (frame >= endFrame) {
      noLoop(); 
    } else {
      automataSetup(); 
    }
  }
}
