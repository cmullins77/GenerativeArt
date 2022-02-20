int rows = 0;
int cols = 16;

int square;
float w = 0;

int[] ruleSet;

int frame = 0;

int[][] colors;
int[][] startColors;

int time = 0;

PrintWriter output;

void setup() {
  output = createWriter("Rules.txt"); 
  size(800,800);
  stroke(color(random(0,256), random(0,256), random(0,256)));
  //fill(color(random(0,256), random(0,256), random(0,256)));
  square = width/cols;
  rows = cols;
  noStroke();
  frameRate(5);
  ruleSet = generateRules();
  colors = new int[cols][rows];
  startColors = new int[cols][rows];
  for (int i = 0; i < cols; i++) {
     for (int j = 0; j < rows; j++) {
        int randomColor = (int)random(0,4);
        randomColor = 1;
        if (j == rows/2) {
          randomColor = 3; 
        }
        colors[i][j] = randomColor;
        startColors[i][j] = randomColor;
     }
  }
  drawSquares();
  
}

void keyPressed() {
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
  }
  
  for (int i = 0; i < cols; i++) {
     for (int j = 0; j < rows; j++) {
        colors[i][j] = startColors[i][j];
        println(startColors[i][j]);
     }
  }
  ruleSet = generateRules();
  //noLoop();
}

void drawSquares() {
   for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
         int currColor = colors[i][j];
         
         if (currColor == 0) {
           fill(0,0,0); 
         } else if (currColor == 1) {
           fill(255,0,0); 
         } else if (currColor == 2) {
           fill(0,255,0); 
         } else {
           fill(255); 
         }
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
     if (l == 3 && m == 0) {
       val = 3; 
     }
     val = val > 3 ? 3 : val < 0 ? 0 : val;
     
     next[i] = val;
   }
   return next;
}

int[] generateRules() {
  int[] rules = new int[11];
  for (int i = 0; i < 11; i++) {
    int rule = (int)random(-3,4);
    rules[i] = rule;
  }
  return rules;
}

boolean calculateValue() {
  boolean red = false;
  boolean green = false;
  boolean black = false;
  boolean white = false;
  
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
         if (r == 255 && g == 0 && b == 0) {
          red = true; 
        } else if (r == 0 && g == 255 && b == 0) {
          green = true; 
        } else if (r == 0 && g == 0 && b == 0) {
          black = true; 
        } else if (r == 255 && g == 255 && b == 255) {
          white = true; 
        } 
      }
    }
  }
  
  return red && green && black && white;
}
