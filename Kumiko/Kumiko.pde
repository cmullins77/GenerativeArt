int rows = 0;
int cols = 10;

int triangleSize = 40;
float w = 0;

int frame = 0;

int[][] colors;

int time = 0;

void setup() {
  size(800,800);
  stroke(color(random(0,256), random(0,256), random(0,256)));
  //fill(color(random(0,256), random(0,256), random(0,256)));
  w = width/cols;
  triangleSize = (int)(w/cos(radians(30)));
  rows = height/(triangleSize/2) + 2;
  if (rows % 2 != 0) {
     rows++; 
  }
  
  colors = new int[cols][rows];
  for (int i = 0; i < cols; i++) {
     for (int j = 0; j < rows; j++) {
        int randomColor = (int)random(0,4);
        colors[i][j] = randomColor;
     }
  }
  drawTriangles();
}

void draw() {
  time++;
  if (time % 10 == 0) {
    save("Kumiko" + frame+ ".jpg");
    frame++;
     drawTriangles(); 
     
  }
}

void drawTriangles() {
  int[][] nextIter = new int[cols][rows];
   for (int i = 0; i < cols; i++) {
      for (int j = -1; j < rows-1; j++) {
         int currColor = colors[i][j+1];
         
         PVector[] vertices = getTriangleVertices(i,j);
         strokeWeight(6);
         triangle(vertices[0].x,vertices[0].y,vertices[1].x,vertices[1].y,vertices[2].x,vertices[2].y);
         
         drawPattern(vertices, currColor);
         
         int[] nPosits = getNeighborPositions(i,j);
         
         nextIter[i][j + 1] = getNextPattern(currColor, nPosits);
     }
   }
   colors = nextIter;
}

PVector[] getTriangleVertices(int i, int j) {
   PVector[] vertices = new PVector[3];
   int x1 = (int)(i * w);
   int y1 = triangleSize/2 * (j+1);
   
   int x2 = (int)((i + 1) * w);
   int y2 = triangleSize/2 * j;
   
   int x3 = (int)((i + 1) * w);
   int y3 = triangleSize/2 * (j+2);
   
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

int getNextPattern(int s, int[] nPosits) {
  int n = getNumNeighbors(nPosits);
  
  int newPattern = s;
  if (s > 0 && n < s * 2) {
    newPattern--; 
  } else if (s > 0 && n > s * 3) {
    newPattern--; 
  } else if (s > 0) {
    newPattern++;
  } else if (s < 3 && n > s * 2 && n < s * 4) {
    newPattern = 1; 
  }
  //if (s == 0 && n >= 3 && n <= 4) {
  //   newPattern = 2; 
  // } else if (s == 0 && n >= 5 && n <= 6) {
  //   newPattern = 1; 
  // } else if (s == 1 && n < 5) {
  //   newPattern = 0; 
  // } else if (s == 1 && n > 6) {
  //   newPattern = 0; 
  // } else if (s == 1) {
  //   newPattern = 2; 
  // } else if (s == 2 && n < 2) {
  //   newPattern = 0;
  // } else if (s == 2 && n < 4) {
  //   newPattern = 1;
  // } else if (s == 2 && n > 7) {
  //   newPattern = 0; 
  // } else if (s == 2 && n > 5) {
  //   newPattern = 1; 
  // } else if (s == 2) {
  //   newPattern = 3; 
  // } else if (s == 3 && n < 2) {
  //   newPattern = 1; 
  // } else if (s == 3 && n < 5) {
  //   newPattern = 2; 
  // } else if (s == 3 && n > 6) {
  //   newPattern = 1; 
  // } else if (s == 3 && n > 4) {
  //   newPattern = 2; 
  // }
   
   return newPattern;
}

void drawPattern(PVector[] verts, int pattern) {
  if (pattern == 2) {
    drawPattern1(verts); 
  } else if (pattern == 1) {
    drawPattern2(verts); 
  } else if (pattern == 0) {
    drawPattern3(verts); 
  }
}

void drawPattern1(PVector[] verts) {
  strokeWeight(2);
  float percent = 0.15;
  
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
    
    PVector center2 = new PVector((prevP.x+p.x+center.x)/3,(prevP.y+p.y+center.y)/3); 
    
    line(p.x,p.y,center.x,center.y);
    line(p.x,p.y,center2.x,center2.y);
    line(prevP.x,prevP.y,center2.x,center2.y);
    line(center.x,center.y,center2.x,center2.y);
    prevP = p;
  }
}
