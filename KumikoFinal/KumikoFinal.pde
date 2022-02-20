int rows = 0;
int cols = 16;//(int)random(4, 25);

float triangleSize = 40;
float w = 0;

int frame = 0;
int framesPerSection = 800;

int[] ruleSet;
int[][] ruleOptions;

int[] goodSets = {0,1,2,3,4,5,6,7,8,9,10,11};//{1, 6, 9, 29, 41, 46, 52, 69, 99, 105, 106};
int chosenRuleSet = 0;

int numPatterns = 20;
int totalPatterns = 20;

int[][] colors;
int[][] startColors;

IntList pList = new IntList();
int frameRate = 0;

int endFrame = 7200;

void setup() {
  readRuleFile();
  size(800,800);
  automataSetup();
  
}

void automataSetup() {
  background(255);
  cols = (int)random(4, 25);
  w = width/(cols*1.0);
  triangleSize = (w/cos(radians(30)));
  rows = (int)(height/(triangleSize/2) + 2);
  if (rows % 2 != 0) {
     rows++; 
  }
  color strokeColor = color(random(0,256), random(0,180), random(0,256));
  while(saturation(strokeColor) < 50 && brightness(strokeColor) > 200) {
    strokeColor = color(random(0,256), random(0,180), random(0,256));
  }
  stroke(strokeColor);
  
  //fill(color(random(0,256), random(0,256), random(0,256)));
  //stroke(60,30,200);
  
  numPatterns = (int)random(3, 21);
  colors = new int[cols][rows];
  startColors = new int[cols][rows];
  for (int j = 0; j < rows; j++) {
    int col = (int)random(-1 * (numPatterns - 1),numPatterns);
    col = 0;
    if (j == rows/2) {
      col = numPatterns - 1; 
    }    
    colors[0][j] = col;
    startColors[0][j] = col;
  }
  for (int i = 1; i < cols; i++) {
     for (int j = 0; j < rows; j++) {
        colors[i][j] = 0;
        startColors[i][j] = 0;
     }
  }
  //ruleSet = ruleOptions[16]; //4,6,8,10,11,15
  for (int i = 0; i < totalPatterns; i++) {
    pList.append(i); 
  }
  pList.shuffle();
  
  chosenRuleSet = (int)random(0,goodSets.length);
  ruleSet = ruleOptions[goodSets[chosenRuleSet]]; 
  
  for (int i = 0; i < cols + 1; i++) {
      drawTriangles();
  }
  
  //frameRate(random(0.1,15));
  frameRate = 15 - cols;
  frameRate = frameRate < 1 ? 1 : frameRate;
  
  framesPerSection = (int)random(650,1500);
}

void draw() {

  save("Kumiko" + frame + ".jpg");
  frame++;
  if (frame % frameRate == 0) {
    background(255);
    drawTriangles(); 
  }
  if (frame % 200 == 0) {
    if (chosenRuleSet == goodSets.length || frame >= endFrame) {
      noLoop(); 
    } else {
      automataSetup(); 
    }
  }
}

void drawTriangles() {
   for (int i = 0; i < cols; i++) {
      for (int j = -1; j < rows-1; j++) {
         int currColor = colors[i][j+1];
         
         PVector[] vertices = getTriangleVertices(i,j);
         strokeWeight(6);
         
         triangle(vertices[0].x,vertices[0].y,vertices[1].x,vertices[1].y,vertices[2].x,vertices[2].y);
         
         drawPattern(vertices, currColor);
     }
   }
   int[][] nextIter = new int[cols][rows];
   for (int i = 1; i < cols; i++) {
     nextIter[i] = colors[i-1]; 
   }
   nextIter[0] = getNextCol(nextIter[1]);
   colors = nextIter;
}

PVector[] getTriangleVertices(int i, int j) {
   PVector[] vertices = new PVector[3];
   int x1 = (int)(i * w);
   float y1 = triangleSize/2 * (j+1);
   
   int x2 = (int)((i + 1) * w);
   float y2 = triangleSize/2 * j;
   
   int x3 = (int)((i + 1) * w);
   float y3 = triangleSize/2 * (j+2);
   
   if (j % 2 == 0 && i % 2 == 0) {
     x1 = (int)(i * w);
     y1 = triangleSize/2 * (j + 1);
     
     x2 = (int)((i + 1) * w);
     y2 = triangleSize/2 * j;
     
     x3 = (int)((i + 1) * w);
     y3 = triangleSize/2 * (j+2);
   } else if (j % 2 == 0) {
     x1 = (int)(i * w);
     y1 = triangleSize/2 * j;
     
     x2 = (int)((i + 1) * w);
     y2 = triangleSize/2 * (j + 1);
     
     x3 = (int)(i * w);
     y3 = triangleSize/2 * (j+2);
   } else if (i % 2 == 0) {
     x1 = (int)(i * w);
     y1 = triangleSize/2 * j;
     
     x2 = (int)((i + 1) * w);
     y2 = triangleSize/2 * (j+1);
     
     x3 = (int)(i * w);
     y3 = triangleSize/2 * (j+2);
     
   }
   vertices[0] = new PVector(x1,y1);  
   vertices[1] = new PVector(x2,y2);  
   vertices[2] = new PVector(x3,y3);  
   
   return vertices;
}

int[] getNeighborPositions(int i, int j) {
  int[] positions = new int[6];
  int n1row, n1col, n2row, n2col, n3row, n3col;
         
  if (j % 2 == 0 && i % 2 == 0) {
   n1row = j - 1;
   n1col = i;
   
   n2row = j;
   n2col = i + 1;
   
   n3row = j + 1;
   n3col = i;
  } else if (j % 2 == 0) {
   n1row = j - 1;
   n1col = i;
   
   n2row = j + 1;
   n2col = i;
   
   n3row = j;
   n3col = i - 1;
  } else if (i % 2 == 0) {
   n1row = j - 1;
   n1col = i;
 
   n2row = j + 1;
   n2col = i;
 
   n3row = j;
   n3col = i - 1;  
  } else {
   n1row = j - 1;
   n1col = i;
   
   n2row = j;
   n2col = i + 1;
   
   n3row = j + 1;
   n3col = i;
  }
  n1row = n1row < -1 ? rows - 2 : n1row > rows - 2 ? -1 : n1row;
  n2row = n2row < -1 ? rows - 2 : n2row > rows - 2 ? -1 : n2row;
  n3row = n3row < -1 ? rows - 2 : n3row > rows - 2 ? -1 : n3row;
   
  n1col = n1col < 0 ? cols - 1 : n1col > cols - 1 ? 0 : n1col;
  n2col = n2col < 0 ? cols - 1 : n2col > cols - 1 ? 0 : n2col;
  n3col = n3col < 0 ? cols - 1 : n3col > cols - 1 ? 0 : n3col;
         
  positions[0] = n1row;
  positions[1] = n1col;
  positions[2] = n2row;
  positions[3] = n2col;
  positions[4] = n3row;
  positions[5] = n3col;
  
  return positions;
}

int getNumNeighbors(int[] nPosits) {
  int num = 0;
  
  num += colors[nPosits[1]][nPosits[0] + 1];
  num += colors[nPosits[3]][nPosits[2] + 1];
  num += colors[nPosits[5]][nPosits[4] + 1];
  
  return num;
}

void drawPattern(PVector[] verts, int pattern) {
  if (pattern == pList.get(0)) {
  } else if (pattern == pList.get(1)) {
    drawPattern1(verts); 
  } else if (pattern == pList.get(2)) {
    drawPattern2(verts); 
  } else if (pattern == pList.get(3)) {
    drawPattern3(verts); 
  } else if (pattern == pList.get(4)) {
    drawPattern4(verts);  
  } else if (pattern == pList.get(5)) {
    drawPattern5(verts);  
  } else if (pattern == pList.get(6)) {
    drawPattern6(verts);  
  } else if (pattern == pList.get(7)) {
    drawPattern7(verts);  
  } else if (pattern == pList.get(8)) {
    drawPattern8(verts);  
  } else if (pattern == pList.get(9)) {
    drawPattern9(verts);  
  } else if (pattern == pList.get(10)) {
    drawPattern10(verts);  
  } else if (pattern == pList.get(11)) {
    drawPattern11(verts);  
  } else if (pattern == pList.get(12)) {
    drawPattern12(verts);  
  } else if (pattern == pList.get(13)) {
    drawPattern13(verts);  
  } else if (pattern == pList.get(14)) {
    drawPattern14(verts);  
  } else if (pattern == pList.get(15)) {
    drawPattern15(verts);  
  } else if (pattern == pList.get(16)) {
    drawPattern16(verts);  
  } else if (pattern == pList.get(17)) {
    drawPattern17(verts);  
  } else if (pattern == pList.get(18)) {
    drawPattern18(verts);  
  } else if (pattern == pList.get(19)) {
    drawPattern19(verts);  
  }
}

void drawPattern1(PVector[] verts) {
  strokeWeight(2);
  float percent = 0.2;
  
  for (int i = 0; i < 3; i++) {
    PVector currP = verts[i];
    PVector prevP = i > 0 ? verts[i-1] : verts[2];
    PVector nextP = i < 2 ? verts[i+1] : verts[0];
    
    PVector p0 = new PVector(prevP.x*percent + currP.x*(1-percent), prevP.y*percent + currP.y*(1-percent));
    PVector p1 = new PVector(prevP.x*percent + nextP.x*(1-percent), prevP.y*percent + nextP.y*(1-percent));
    
    line(p0.x,p0.y,p1.x,p1.y);
  }
}

void drawPattern2(PVector[] verts) {
  strokeWeight(3);
  PVector center = new PVector(0,0);
  for (int i = 0; i < 3; i++) {
    center.x += verts[i].x;
    center.y += verts[i].y;
  }
  center.x /= 3;
  center.y /= 3;
  
  for (int i = 0; i < 3; i++) {
    PVector p = verts[i];
    line(p.x,p.y,center.x,center.y);
  }
}

void drawPattern3(PVector[] verts) {
  strokeWeight(3);
  PVector center = new PVector((verts[0].x+verts[1].x+verts[2].x)/3,(verts[0].y+verts[1].y+verts[2].y)/3); 
  
  PVector prevP = verts[2];
  for (int i = 0; i < 3; i++) {
    PVector p = verts[i];
    
    PVector lCent = new PVector((prevP.x+p.x)/2, (prevP.y+p.y)/2);
    PVector center2 = new PVector((lCent.x+center.x)/2,(lCent.y+center.y)/2); 
    
    line(p.x,p.y,center.x,center.y);
    line(p.x,p.y,center2.x,center2.y);
    line(prevP.x,prevP.y,center2.x,center2.y);
    line(center.x,center.y,center2.x,center2.y);
    prevP = p;
  }
}

void drawPattern4(PVector[] verts) {
  PVector center = new PVector((verts[0].x+verts[1].x+verts[2].x)/3,(verts[0].y+verts[1].y+verts[2].y)/3); 
  
  float percent = 0.3;
  
  for (int i = 0; i < 3; i++) {
    PVector currP = verts[i];
    PVector prevP = i > 0 ? verts[i-1] : verts[2];
    PVector nextP = i < 2 ? verts[i+1] : verts[0];
    
    strokeWeight(6);
    
    PVector p0 = new PVector(prevP.x*percent + currP.x*(1-percent), prevP.y*percent + currP.y*(1-percent));
    PVector p1 = new PVector(nextP.x*percent + currP.x*(1-percent), nextP.y*percent + currP.y*(1-percent));
    line(p0.x,p0.y,p1.x,p1.y);
    
    strokeWeight(2);
    
    PVector p2 = new PVector((p0.x + p1.x)/2, (p0.y + p1.y)/2);
    line(p2.x, p2.y, center.x, center.y);
  }
}

void drawPattern5(PVector[] verts) {
  PVector center = new PVector((verts[0].x+verts[1].x+verts[2].x)/3,(verts[0].y+verts[1].y+verts[2].y)/3); 
  
  float percent = 0.3;
  
  for (int i = 0; i < 3; i++) {
    PVector currP = verts[i];
    PVector prevP = i > 0 ? verts[i-1] : verts[2];
    PVector nextP = i < 2 ? verts[i+1] : verts[0];
    
    strokeWeight(4);
    
    PVector p0 = new PVector(prevP.x*percent + currP.x*(1-percent), prevP.y*percent + currP.y*(1-percent));
    PVector p1 = new PVector(nextP.x*percent + currP.x*(1-percent), nextP.y*percent + currP.y*(1-percent));
    line(p0.x,p0.y,p1.x,p1.y);
    

    line(currP.x, currP.y, center.x, center.y);
  }
}

void drawPattern6(PVector[] verts) {
  strokeWeight(4);
  for (int i = 0; i < 3; i++) {
    PVector p = verts[i];
    PVector prevP = i > 0 ? verts[i-1] : verts[2];
    PVector nextP = i < 2 ? verts[i+1] : verts[0];
    
    PVector midNext = new PVector((p.x + nextP.x)/2, (p.y + nextP.y)/2);
    PVector midPrev = new PVector((p.x + prevP.x)/2, (p.y + prevP.y)/2);
    PVector midNextPrev = new PVector((prevP.x + nextP.x)/2, (prevP.y + nextP.y)/2);
    
    PVector mid1 = new PVector((p.x + midNext.x + midPrev.x)/3, (p.y + midNext.y + midPrev.y)/3);
    PVector mid2 = new PVector((midNext.x + nextP.x + midNextPrev.x)/3, (midNext.y + nextP.y + midNextPrev.y)/3);
    
    line(p.x, p.y, mid1.x, mid1.y);
    line(mid1.x, mid1.y, midNext.x, midNext.y);
    line(midNext.x, midNext.y, mid2.x, mid2.y);
    line(mid2.x, mid2.y, nextP.x, nextP.y);
  }
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
     if (l == numPatterns - 1 && m == 0) {
       val = numPatterns - 1; 
     }
     val = val > numPatterns - 1 ? numPatterns - 1 : val < 0 ? 0 : val;
     
     next[i] = val;
   }
   return next;
}


void drawPattern15(PVector[] verts) {
  float percent = 0.65;
  strokeWeight(4);
  PVector center = new PVector((verts[0].x+verts[1].x+verts[2].x)/3,(verts[0].y+verts[1].y+verts[2].y)/3); 
  
  for (int i = 0; i < 3; i++) {
    PVector p = verts[i];
    PVector prevP = i > 0 ? verts[i-1] : verts[2];
    PVector nextP = i < 2 ? verts[i+1] : verts[0];
    
    float d = p.dist(center);
    float h = d*percent;
    
    float w = tan(radians(30))*h;
    
    float shortSide = w * cos(radians(60));
    float hyp = h/sin(radians(60));

    float edgeLength = hyp - shortSide;
    float edgePercent = edgeLength/p.dist(nextP);
    
    
    PVector p0 = new PVector(p.x*(1-percent) + center.x*percent, p.y*(1-percent) + center.y*percent);
    PVector p1 = new PVector(p.x*(1-edgePercent) + nextP.x*edgePercent, p.y*(1-edgePercent) + nextP.y*edgePercent);
    PVector p2 = new PVector(p.x*(1-edgePercent) + prevP.x*edgePercent, p.y*(1-edgePercent) + prevP.y*edgePercent);
    
    line(center.x,center.y, p0.x,p0.y);
    line(p1.x,p1.y, p0.x,p0.y);
    line(p2.x,p2.y, p0.x,p0.y);
  }
}

void drawPattern19(PVector[] verts) {
  float percent = 1/3.0;
  strokeWeight(4);
  PVector center = new PVector((verts[0].x+verts[1].x+verts[2].x)/3,(verts[0].y+verts[1].y+verts[2].y)/3); 
  
  for (int i = 0; i < 3; i++) {
    PVector p = verts[i];
    PVector prevP = i > 0 ? verts[i-1] : verts[2];
    PVector nextP = i < 2 ? verts[i+1] : verts[0];
    
    float d = p.dist(center);
    float h = d*percent;
    
    float sideDist = h/sin(radians(60));
    
    float edgeLength = p.dist(prevP);
    float edgePercent = sideDist/edgeLength;
    
    float w = cos(radians(60)) * (edgeLength - sideDist); 
    float hyp = w/cos(radians(30));
    float hypPercent = hyp/d;
    
    PVector p0 = new PVector(p.x * (1-edgePercent) + prevP.x * edgePercent, p.y * (1-edgePercent) + prevP.y * edgePercent);
    PVector p1 = new PVector(p.x * (1-edgePercent) + nextP.x * edgePercent, p.y * (1-edgePercent )+ nextP.y * edgePercent);
    
    PVector p2 = new PVector(prevP.x * (1-hypPercent) + center.x*hypPercent, prevP.y * (1-hypPercent) + center.y*hypPercent);
    PVector p3 = new PVector(nextP.x * (1-hypPercent) + center.x*hypPercent, nextP.y * (1-hypPercent) + center.y*hypPercent);
    
    line(prevP.x,prevP.y,p2.x,p2.y);
    line(p0.x, p0.y, p2.x, p2.y);
    line(p1.x, p1.y, p3.x, p3.y);
  }
}

void drawPattern18(PVector[] verts) {
  float percent = 1/3.0;
  strokeWeight(4);
  PVector center = new PVector((verts[0].x+verts[1].x+verts[2].x)/3,(verts[0].y+verts[1].y+verts[2].y)/3); 
  
  for (int i = 0; i < 3; i++) {
    PVector p = verts[i];
    PVector prevP = i > 0 ? verts[i-1] : verts[2];
    PVector nextP = i < 2 ? verts[i+1] : verts[0];
    
    float d = p.dist(center);
    float h = d*percent;
    
    float sideDist = h/sin(radians(60));
    
    float edgeLength = p.dist(prevP);
    float edgePercent = sideDist/edgeLength;
    
    float w = cos(radians(60)) * (edgeLength - sideDist); 
    float hyp = w/cos(radians(30));
    float hypPercent = hyp/d;
    
    PVector p0 = new PVector(p.x * (1-edgePercent) + prevP.x * edgePercent, p.y * (1-edgePercent) + prevP.y * edgePercent);
    PVector p1 = new PVector(p.x * (1-edgePercent) + nextP.x * edgePercent, p.y * (1-edgePercent )+ nextP.y * edgePercent);
    
    PVector p2 = new PVector(prevP.x * (1-hypPercent) + center.x*hypPercent, prevP.y * (1-hypPercent) + center.y*hypPercent);
    PVector p3 = new PVector(nextP.x * (1-hypPercent) + center.x*hypPercent, nextP.y * (1-hypPercent) + center.y*hypPercent);
    
    line(p.x,p.y,center.x,center.y);
    line(p0.x, p0.y, p2.x, p2.y);
    line(p1.x, p1.y, p3.x, p3.y);
  }
}

void drawPattern17(PVector[] verts) {
  strokeWeight(4);
  PVector center = new PVector((verts[0].x+verts[1].x+verts[2].x)/3,(verts[0].y+verts[1].y+verts[2].y)/3); 
  
  for (int i = 0; i < 3; i++) {
    PVector p = verts[i];
    PVector prevP = i > 0 ? verts[i-1] : verts[2];
    PVector nextP = i < 2 ? verts[i+1] : verts[0];
    
    PVector lCent = new PVector((prevP.x+p.x)/2, (prevP.y+p.y)/2);
    PVector lCent2 = new PVector((nextP.x+p.x)/2, (nextP.y+p.y)/2);
    
    line(p.x,p.y,center.x,center.y);
    line(lCent.x, lCent.y, lCent2.x, lCent2.y);
  }
}


void drawPattern16(PVector[] verts) {
  PVector p0 = verts[0];
  PVector p1 = verts[1];
  PVector p2 = verts[2];
  
  PVector lp0 = new PVector((verts[1].x*2 + verts[2].x)/3, (verts[1].y*2 + verts[2].y)/3);
  PVector lp1 = new PVector((verts[2].x*2 + verts[0].x)/3, (verts[2].y*2 + verts[0].y)/3);
  PVector lp2 = new PVector((verts[0].x*2 + verts[1].x)/3, (verts[0].y*2 + verts[1].y)/3);
  
  PVector md0 = new PVector((lp0.x*6 + p0.x)/7, (lp0.y*6 + p0.y)/7);
  PVector md1 = new PVector((lp1.x*6 + p1.x)/7, (lp1.y*6 + p1.y)/7);
  PVector md2 = new PVector((lp2.x*6 + p2.x)/7, (lp2.y*6 + p2.y)/7);
  
  strokeWeight(4);
  line(p0.x, p0.y, md0.x, md0.y);
  line(p1.x, p1.y, md1.x, md1.y);
  line(p2.x, p2.y, md2.x, md2.y); 
}

void drawPattern14(PVector[] verts) {
  strokeWeight(3);
  PVector center = new PVector((verts[0].x+verts[1].x+verts[2].x)/3,(verts[0].y+verts[1].y+verts[2].y)/3); 
  
  PVector prevP = verts[2];
  for (int i = 0; i < 3; i++) {
    PVector p = verts[i];
    
    PVector lCent = new PVector((prevP.x+p.x)/2, (prevP.y+p.y)/2);
    PVector center2 = new PVector((lCent.x+center.x)/2,(lCent.y+center.y)/2); 
    
    line(p.x,p.y,center2.x,center2.y);
    line(prevP.x,prevP.y,center2.x,center2.y);
    line(center.x,center.y,center2.x,center2.y);
    prevP = p;
  }
}

void drawPattern13(PVector[] verts) {
  strokeWeight(4);
  float percent = 0.45;
  
  for (int i = 0; i < 3; i++) {
    PVector currP = verts[i];
    PVector prevP = i > 0 ? verts[i-1] : verts[2];
    PVector nextP = i < 2 ? verts[i+1] : verts[0];
    
    PVector p0 = new PVector(prevP.x*percent + currP.x*(1-percent), prevP.y*percent + currP.y*(1-percent));
    PVector p1 = new PVector(prevP.x*percent + nextP.x*(1-percent), prevP.y*percent + nextP.y*(1-percent));
    
    line(p0.x,p0.y,p1.x,p1.y);
  }
}

void drawPattern12(PVector[] verts) {
  PVector center = new PVector((verts[0].x+verts[1].x+verts[2].x)/3,(verts[0].y+verts[1].y+verts[2].y)/3); 
  
  float percent1 = 0.2;
  float percent2 = 0.3;
  
  for (int i = 0; i < 3; i++) {
    PVector currP = verts[i];
    PVector prevP = i > 0 ? verts[i-1] : verts[2];
    PVector nextP = i < 2 ? verts[i+1] : verts[0];
    
    strokeWeight(4);
    
    PVector p0 = new PVector(prevP.x*percent1 + currP.x*(1-percent1), prevP.y*percent1 + currP.y*(1-percent1));
    PVector p1 = new PVector(nextP.x*percent1 + currP.x*(1-percent1), nextP.y*percent1 + currP.y*(1-percent1));
    line(p0.x,p0.y,p1.x,p1.y);
   
    
    PVector p2 = new PVector((p0.x + p1.x)/2, (p0.y + p1.y)/2);
    line(p2.x, p2.y, center.x, center.y);
    
    PVector p3 = new PVector(prevP.x*percent2 + currP.x*(1-percent2), prevP.y*percent2 + currP.y*(1-percent2));
    PVector p4 = new PVector(nextP.x*percent2 + currP.x*(1-percent2), nextP.y*percent2 + currP.y*(1-percent2));
    line(p3.x,p3.y,p4.x,p4.y);
  }
}

void drawPattern11(PVector[] verts) {
  PVector m = new PVector((verts[0].x + verts[1].x + verts[2].x)/3,(verts[0].y + verts[1].y + verts[2].y)/3) ;
  strokeWeight(4);
  for (int i = 0; i < 3; i++) {
    PVector currP = verts[i];
    PVector nextP = i == 2 ? verts[0] : verts[i+1];
    PVector prevP = i == 0 ? verts[2] : verts[i-1];
    PVector lm = new PVector((prevP.x + nextP.x)/2, (prevP.y + nextP.y)/2);
    PVector p = new PVector((lm.x + m.x)/2, (lm.y + m.y)/2);
    
    line(p.x,p.y,currP.x, currP.y);
  }
}

void drawPattern10(PVector[] verts) {
  PVector m = new PVector((verts[0].x + verts[1].x + verts[2].x)/3,(verts[0].y + verts[1].y + verts[2].y)/3) ;
  strokeWeight(4);
  for (int i = 0; i < 3; i++) {
    PVector currP = verts[i];
    PVector nextP = i == 2 ? verts[0] : verts[i+1];
    PVector p = new PVector((currP.x + nextP.x)/2, (currP.y + nextP.y)/2);
    
    line(p.x,p.y,m.x,m.y);
  }
}

void drawPattern9(PVector[] verts) {
  PVector p0 = verts[1];
  PVector p1 = new PVector((verts[0].x*2 + verts[2].x)/3, (verts[0].y*2 + verts[2].y)/3);
  
  PVector p2 = verts[2];
  PVector p3 = new PVector((verts[0].x*2 + verts[1].x)/3, (verts[0].y*2 + verts[1].y)/3);
  
  strokeWeight(4);
  line(p0.x, p0.y, p1.x, p1.y);
  line(p2.x, p2.y, p3.x, p3.y);
}

void drawPattern8(PVector[] verts) {
  PVector p0 = verts[0];
  PVector p1 = new PVector((verts[1].x*2 + verts[2].x)/3, (verts[1].y*2 + verts[2].y)/3);
  PVector p2 = new PVector((verts[1].x + verts[2].x)/2, (verts[1].y + verts[2].y)/2);
  PVector p3 = new PVector((verts[1].x + verts[2].x*2)/3, (verts[1].y + verts[2].y*2)/3);
  strokeWeight(4);
  line(p0.x, p0.y, p1.x, p1.y);
  line(p0.x, p0.y, p2.x, p2.y);
  line(p0.x, p0.y, p3.x, p3.y);
}

void drawPattern7(PVector[] verts) {
  PVector p0 = verts[0];
  PVector p1 = new PVector((verts[1].x*2 + verts[2].x)/3, (verts[1].y*2 + verts[2].y)/3);
  strokeWeight(4);
  line(p0.x, p0.y, p1.x, p1.y);
}

void readRuleFile() {
   String[] lines = loadStrings("Rules.txt");
   ruleOptions = new int[lines.length][11];
   
   int ruleVersion = 0;
   for (String line : lines) {
     String[] separatedLine = line.split(":");
     String[] ruleStrings = separatedLine[1].split(",");
     int ruleNum = 0;
     for (String rule : ruleStrings) {
        ruleOptions[ruleVersion][ruleNum] = Integer.parseInt(rule);
        ruleNum++;
     }
     ruleVersion++;
   }
   ruleSet = ruleOptions[goodSets[chosenRuleSet]];
}
