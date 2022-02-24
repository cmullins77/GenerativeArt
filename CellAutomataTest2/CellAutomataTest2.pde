int rows = 0;
int cols = width;

int square;
float w = 0;

int[] ruleSet;

int frame = 0;

int[][] colors;
int[][] startColors;

int time = 0;

int numColors = 20;
boolean isGradient = false;
color[] rgb;
PrintWriter output;

int found = 0;
int goal = 9;
int increment = 10;

void setup() {
  output = createWriter("Rules.txt"); 
  size(800, 600);
  colorMode(HSB, 360, 1, 1);
  //stroke(color(random(0,256), random(0,256), random(0,256)));
  //fill(color(random(0,256), random(0,256), random(0,256)));
  cols = 100;
  square = width/cols;
  rows = height/square;
  noStroke(); 
  
  setupTest();
}

void setupTest() {
  numColors = (int)random(4, 20);
  ruleSet = generateRules();
  println("cols: " + cols);
  colors = new int[cols][rows];
  startColors = new int[cols][rows];
  for (int i = 0; i < cols; i++) {
     for (int j = 0; j < rows; j++) {
        int randomColor = (int)random(0,4);
        colors[i][j] = randomColor;
        startColors[i][j] = randomColor;
     }
  }
  rgb = new color[numColors];
  if (isGradient) {
    float h1 = random(0,360);
    float s1 = random(0,1);
    float v1 = random(0,1);
    float h2 = random(0,360);
    float s2 = random(0,1);
    float v2 = random(0,1);
    for (int i = 0; i < numColors; i++) {
      //float r = random(0,360); 
      //float g = random(0,1); 
      //float b = random(0,1); 
      //r = i*(255/(numColors-1));
      //g = i*(255/(numColors-1));
      //b = i*(255/(numColors-1));
      float t = (i/(numColors - 1.0));
      float r = t*h1 + (1-t)*h2;
      float g = t*s1 + (1-t)*s2;
      float b = t*v1 + (1-t)*v2;
      rgb[i] = color(r,g,b);
    }
  } else {
    for (int i = 0; i < numColors; i++) {
      rgb[i] = color(random(0,360),random(0,1),random(0,1));
    }
  }
  drawSquares();
}

void keyPressed() {
  //noLoop();
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  exit(); // Stops the program
}

void draw() {
  for (int i = 0; i < cols*3; i++) {
    drawSquares(); 
  }
  if (calculateValue()) {
    save("Kumiko" + frame + ".jpg");
  
    String setString = frame + ":";
    setString += ruleSet[0];
    for (int i = 1; i < 11; i++) {
      setString += "," + ruleSet[i];
    }
    output.println(setString);
    
    frame++; 
    found++;
    if (found == goal) {
      found = 0;
      goal += increment;
      setupTest();
    }
  }
  
  for (int i = 0; i < cols; i++) {
     for (int j = 0; j < rows; j++) {
        colors[i][j] = startColors[i][j];
        //println(startColors[i][j]);
     }
  }
  ruleSet = generateRules();
  //noLoop();
}

void drawSquares() {
   for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
         int currColor = colors[i][j];
         
         fill(rgb[currColor]);
         float x = i*square;
         float y = j*square;
         rect(x,y,square,square);
     }
   }
   int[][] nextIter = new int[cols][rows];
   for (int i = 1; i < cols; i++) {
     nextIter[i] = colors[i-1]; 
   }
   nextIter[0] = getNextCol(nextIter[1]);
   colors = nextIter;
}

int[] getNextCol(int[] prev) {
   int[] next = new int[rows];
   for (int i = 0; i < rows; i++) {
     int prevI = i == 0 ? rows - 1 : i - 1; 
     int nextI = i == rows - 1 ? 0 : i + 1;
     
     int l = prev[prevI];
     int m = prev[i];
     int r = prev[nextI];
     
     int valL = l - m;
     int valR = r - m;
     
     int val = m;
     if (valL == 0 && valR == 0) {
        val += ruleSet[0];
     } else if (valL > 0 && valR > 0) {
       val += ruleSet[1];
     } else if (valL < 0 && valR < 0) {
       val += ruleSet[2];
     } else if (valL == 0 && valR < 0) {
       val += ruleSet[3];
     } else if (valL > 0 && valR == 0) {
       val += ruleSet[4];
     } else if (valL < 0 && valR == 0) {
       val += ruleSet[5];
     } else if (valL == 0 && valR > 0) {
       val += ruleSet[6];
     }  else if (valL >= 0 && valR < 0) {
       val += ruleSet[7];
     } else if (valL > 0 && valR <= 0) {
       val += ruleSet[8];
     } else if (valL < 0 && valR >= 0) {
       val += ruleSet[9];
     } else if (valL <= 0 && valR > 0) {
       val += ruleSet[10];
     }
     if (l == numColors-1 && m == 0) {
       val = numColors - 1; 
     }
     val = val > numColors-1 ? numColors-1 : val < 0 ? 0 : val;
     
     next[i] = val;
   }
   return next;
}

int[] generateRules() {
  int[] rules = new int[11];
  for (int i = 0; i < 11; i++) {
    int rule = (int)random((numColors-1)*-1,numColors);
    rules[i] = rule;
  }
  return rules;
}

boolean calculateValue() { 
  boolean[] bools = new boolean[numColors]; //<>//
  
  for (int x = 1; x < width-1; x++) {
    for (int y = 0; y < height; y++) {
      for (int i = 0; i < numColors; i++) {
        color compare = rgb[i];
        float compr = red(compare);
        float compg = green(compare);
        float compb = blue(compare);
        
        color col = get(x,y);
        float r = red(col);
        float g = green(col);
        float b = blue(col);
        
        color col0 = get(x-1,y);
        float r0 = red(col0);
        float g0 = green(col0);
        float b0 = blue(col0);
        
        color col2 = get(x+1,y);
        float r2 = red(col2);
        float g2 = green(col2);
        float b2 = blue(col2);
        if (!(r == r0 && r == r2 && g == g0 && g == g2 && b == b0 && b == b2)) {
          //println("Not Ajacent");
           if (r == compr && g == compg && b == compb) {
            bools[i] = true;
          }
        }
      }
    }
  }
  //println(bools);
  boolean allCols = true;
  for (int i = 0; i < numColors; i++) {
    allCols &= bools[i]; 
  }
  return allCols;
}
