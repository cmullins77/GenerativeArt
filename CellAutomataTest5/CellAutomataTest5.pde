int rows = 0;
int cols = 200;
int origCols = 200;
int panels = 3;

int numColors = 10;

int square;
float w = 0;

int[] ruleSet;

int frame = 0;

int[][] colors;
int[][] startColors;
color[] colorList;

int time = 0;

int numFrames = 0;
int version = 0;

int baseRed = -1;
int baseGreen = -1;
int baseBlue = -1;

void setup() {
  size(3000,1000);

  square = (int)(1000/(cols));
  rows = (int)(height/square) + 1;
  noStroke();

  ruleSet = generateRules();
  generateNewSetup();
}

void draw() {
  generateNewSetup();
  findNewRules();
  useNewRuleset();
  save(frame + ".png");
  frame++;
}

void drawSquares() {
   for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
         int currColor = colors[i][j];
         fill(colorList[currColor]);
         
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
     if (l == numColors - 1 && m == 0) {
       val = numColors - 1; 
     }
     val = val > numColors - 1 ? numColors - 1 : val < 0 ? 0 : val;
     
     next[i] = val;
   }
   return next;
}

int[] generateRules() {
  int[] rules = new int[11];
  for (int i = 0; i < 11; i++) {
    int rule = (int)random(-numColors + 1, numColors);
    rules[i] = rule;
  }
  return rules;
}

boolean calculateValue() {
  boolean[] checkList = new boolean[numColors];
  for (int i = 0; i < numColors; i++) {
    checkList[i] = false; 
  }
  
  for (int x = 1; x < 960-1; x++) {
    for (int y = 0; y < height; y++) {
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
         for (int i = 0; i < numColors; i++) {
            color col1 = colorList[i];
            float r1 = red(col1);
            float g1 = green(col1);
            float b1 = blue(col1);
            
            if (r == r1 && g == g1 && b == b1) {
              checkList[i] = true; 
            }
         }
      }
    }
  }
  boolean check = true;
  for (int i = 0; i < numColors; i++) {
     check &= checkList[i]; 
  }
  return check;
}

void findNewRules() {
  boolean check = false;
  while (!check) {
    resetColors();
    ruleSet = generateRules();
    
    for (int i = 0; i < cols*3; i++) {
      drawSquares(); 
    }
  
    check = calculateValue();
  }
}

void resetColors() {
  for (int i = 0; i < cols; i++) {
       for (int j = 0; j < rows; j++) {
          colors[i][j] = startColors[i][j];
       }
    }
}

void useNewRuleset() {
  println("Done Generating");
  println(ruleSet);
  cols = cols*panels;
  
  colors = new int[cols][rows];
  startColors = new int[cols][rows];
  for (int i = 0; i < cols; i++) {
     for (int j = 0; j < rows; j++) {
        int randomColor = (int)random(numColors);
        colors[i][j] = randomColor;
        startColors[i][j] = randomColor;
     }
  }
  for (int i = 0; i < cols*1.5; i++) {
    drawSquares(); 
  }
  println("Used New Rules");
}

void generateNewSetup() {
  cols = origCols;
  numColors = (int)random(5, 20);
  
  colorList = new color[numColors];
  for (int i = 0; i < numColors; i++) {
    int red = baseRed == -1 ? (int)random(256) : baseRed;
    int green = baseGreen == -1 ? (int)random(256) : baseGreen;
    int blue = baseBlue == -1 ? (int)random(256) : baseBlue;
    if (baseRed == -2 && baseGreen == -2 && baseBlue == -2) {
      red = (int)random(256);
      green = red;
      blue = red;
    }
    colorList[i] = color(red, green, blue); 
  }
  
  colors = new int[cols][rows];
  startColors = new int[cols][rows];
  for (int i = 0; i < cols; i++) {
     for (int j = 0; j < rows; j++) {
        int randomColor = (int)random(numColors);
        colors[i][j] = randomColor;
        startColors[i][j] = randomColor;
     }
  }
}
