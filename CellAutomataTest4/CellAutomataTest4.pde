int rows = 0;
int cols = 100;

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

int changeProbability = 10;

int mousePressedCount = 0;
boolean holdingMouseDown = false;

void setup() {
  size(800,800);

  square = (int)(width/(cols-1));
  rows = (int)(height/square) + 1;
  noStroke();

  ruleSet = generateRules();
  generateNewSetup();
}

void draw() {
  if (frame == numFrames) {
     frame = 0;
     numFrames = (int)random(300, 1000);
     
     generateNewSetup();
     findNewRules();
     version++;
     
     resetColors2();
  }
  drawSquares();
  save(version + "/" + frame + ".png");
  frame++;
  
  if (holdingMouseDown) {
    mousePressedCount+=2;
    fill(255,255,255,125);
    //circle(mouseX,mouseY, square*mousePressedCount);
  }
}

void mousePressed() {
  holdingMouseDown = true;
}

void mouseReleased() {
  holdingMouseDown = false;
  
  int xPos = mouseX;
  int yPos = mouseY;
  
  int row = yPos/square;
  int col = xPos/square;
  
  int rad = mousePressedCount;
  
  for (int i = row - rad; i <= row + rad; i++) {
    for (int j = col - rad; j <= col + rad; j++) {
      if (pow(j - col, 2) + pow(i - row, 2) - rad*rad <= 0) {
        int colIndex = 0;
        if (mouseButton == LEFT) {
          colIndex = (int)random(numColors);
        }
        
        int updatedJ = j < 0 ? 0 : j >= cols ? cols - 1 : j;
        int updatedI = i < 0 ? 0 : i >= rows ? rows - 1 : i;
        colors[updatedJ][updatedI] = colIndex;
      }
    }
  }
  
  
  mousePressedCount = 0;
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
   colors = getNextCol(colors);
}

int[][] getNextCol(int[][] prev) {
   int[][] next = new int[cols][rows];
   for (int i = 0; i < rows; i++) {
     for (int j = 0; j < cols; j++) {
       int change = (int)random(100);
       if (changeProbability >= change) {
         int prevI = i == 0 ? rows - 1 : i - 1; 
         int nextI = i == rows - 1 ? 0 : i + 1;
         
         int prevJ = j == 0 ? cols - 1 : j - 1; 
         int nextJ = j == cols - 1 ? 0 : j + 1;
         
         int l = prev[j][prevI];
         int m = prev[j][i];
         int r = prev[j][nextI];
         int u = prev[prevJ][i];
         int d = prev[nextJ][i];
         
         int valL = l - m;
         int valR = r - m;
         int valU = u - m;
         int valD = d - m;
         
         int val = m;
         if (valL == 0) {
           val += ruleSet[0]; 
         } else if (valL < 0) {
           val += ruleSet[1]; 
         } else {
           val += ruleSet[2]; 
         }
         
         if (valR == 0) {
           val += ruleSet[3]; 
         } else if (valR < 0) {
           val += ruleSet[4]; 
         } else {
           val += ruleSet[5]; 
         }
         
         if (valU == 0) {
           val += ruleSet[6]; 
         } else if (valU < 0) {
           val += ruleSet[7]; 
         } else {
           val += ruleSet[8]; 
         }
         
         if (valD == 0) {
           val += ruleSet[9]; 
         } else if (valD < 0) {
           val += ruleSet[10]; 
         } else {
           val += ruleSet[11]; 
         }
         
         if (l == numColors - 1 && m == 0) {
           val = numColors - 1; 
         }
         val = val > numColors - 1 ? numColors - 1 : val < 0 ? 0 : val;
         next[j][i] = val;
       } else {
         next[j][i] = prev[j][i];
       }
     }
   }
   return next;
}

int[] generateRules() {
  int[] rules = new int[12];
  for (int i = 0; i < 12; i++) {
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
  
  for (int x = 1; x < width-1; x++) {
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
    
    for (int i = 0; i < 100; i++) {
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

void resetColors2() {
  for (int i = 0; i < cols; i++) {
       for (int j = 0; j < rows; j++) {
          colors[i][j] = 0;
       }
    }
}


void generateNewSetup() {
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
  
  changeProbability = (int)random(2, 50);
}
