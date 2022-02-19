int rows = 0;
int cols = 10;

int square;
float w = 0;

int frame = 0;

int[][] colors;

int time = 0;

void setup() {
  size(800,800);
  stroke(color(random(0,256), random(0,256), random(0,256)));
  //fill(color(random(0,256), random(0,256), random(0,256)));
  square = width/cols;
  rows = cols;
  noStroke();
  frameRate(5);
  
  colors = new int[cols][rows];
  for (int i = 0; i < cols; i++) {
     for (int j = 0; j < rows; j++) {
        int randomColor = (int)random(0,4);
        colors[i][j] = randomColor;
     }
  }
  drawSquares();
}

void draw() {
  save("Kumiko" + frame + ".jpg");
  drawSquares(); 
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
        val = m;
     } else if (valL > 0 && valR > 0) {
       val = m; 
     } else if (valL < 0 && valR < 0) {
       val = m; 
     } else if (valL == 0 && valR < 0) {
       val-=2; 
     } else if (valL > 0 && valR == 0) {
       val+=2;
     } else if (valL < 0 && valR == 0) {
       val-=2; 
     } else if (valL == 0 && valR > 0) {
       val+=1;
     }  else if (valL >= 0 && valR < 0) {
       val--; 
     } else if (valL > 0 && valR <= 0) {
       val++;
     } else if (valL < 0 && valR >= 0) {
       val--; 
     } else if (valL <= 0 && valR > 0) {
       val++;
     }
     if (l == 3 && m == 0) {
       val = 3; 
     }
     val = val > 3 ? 3 : val < 0 ? 0 : val;
     
     next[i] = val;
   }
   return next;
}
