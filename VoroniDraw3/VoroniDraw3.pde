boolean placeDots = true;
boolean removeDots = false;
boolean moveDots = false;

boolean showingVoronoi = true;
boolean hideSites = true;

int radius = 10;

int dotMoving = -1;

int W = 1400;
int H = 800;

ArrayList<PVector> points = new ArrayList<PVector>();

float cellDistance = 300;

PImage goalImg;
int imgDisplayMode = 0;

boolean started = false;
int frameNum = 0;
int framePart = 0;

int goalFit = 0;

void setup(){
  size(1400, 900, P3D);
  ortho(-W>>1, W>>1, -H>>1, H>>1);
  noStroke();
  background(255);
  selectInput("Select a Goal Image:", "selectGoal");
  
  //frameRate(2);
}

void selectGoal(File selection) {
  goalImg = loadImage(selection.getAbsolutePath());
  goalFit = getGoalFitness(0.9);
  print(goalFit);
  started = true;
}

void mousePressed() {
  if (placeDots) {
    PVector position = new PVector(mouseX, mouseY);
    points.add(position);
  }
  if (removeDots) {
    int posX = mouseX;
    int posY = mouseY;
    
    for (int i = 0; i < points.size(); i++) {
        float pX = points.get(i).x;
        float pY = points.get(i).y;
        
        if (posX - radius <= pX && posX + radius >= pX && posY - radius <= pY && posY + radius >= pY) {
          points.remove(i);
          i--;
        }
    }
  }
  if (moveDots) {
    int posX = mouseX;
    int posY = mouseY;
    
    for (int i = 0; i < points.size(); i++) {
        float pX = points.get(i).x;
        float pY = points.get(i).y;
        
        if (posX - radius <= pX && posX + radius >= pX && posY - radius <= pY && posY + radius >= pY) {
          dotMoving = i;
        }
    }
  }
}

void mouseReleased() {
  if (moveDots && dotMoving != -1) {
    
    dotMoving = -1; 
  }
}

void keyPressed() {
  if (key == '1') {
      placeDots = true;
      removeDots = false;
      moveDots = false;
  } else if (key == '2') {
      placeDots = false;
      removeDots = true;
      moveDots = false;
  } else if (key == '3') {
      placeDots = false;
      removeDots = false;
      moveDots = true;
  } else if (key == 'q') {
    cellDistance+=10; 
  } else if (key == 'w') {
    cellDistance-=10; 
  }
}

void draw() {
  
  if (started) {
    if (framePart % 3 == 0) {
      background(255);
      fill(0);
      generatePoints();
      hideSites = false;
      drawCells();
      save(frameNum + "-1.png");
    } else if (framePart % 3 == 1) {
      background(255);
      hideSites = true;
      drawCells();
      save(frameNum + "-2.png"); 
    } else { //<>//
      getOverlap();
      int fitness = calculateFitness();
      if (fitness >= goalFit) {
        save(frameNum + "-" + fitness + "-3.png");
        frameNum++;
      }
    }
    framePart++;
  }
}

void renderWithoutVoronoi() {
    if (points.size() > 0) {
    PVector p0 = points.get(0);
    circle(p0.x, p0.y, radius); 
  }
  for(int i = 1; i < points.size(); i++) {
    PVector p0 = points.get(i-1);
    PVector p1 = points.get(i);
    
    line(p0.x, p0.y, p1.x, p1.y);
    circle(p1.x, p1.y, radius);
  }
}

void generatePoints() {
  points = new ArrayList<PVector>();
  
  int startX = (int)(width/2 - cellDistance/2);
  int startY = (int)(height/2 - cellDistance/2);
  int endX = (int)(width/2 + cellDistance/2);
  int endY = (int)(height/2 + cellDistance/2);
  
  int numPoints = (int)random(3,20);
  cellDistance = goalImg.width;
  int spread = (int)random(cellDistance*.1, cellDistance * .6);
  
  PVector prevP = new PVector(random(startX, endX), random(startY, endY));
  points.add(prevP);
  for (int i = 0; i < numPoints; i++) {
    float changeX = random(-spread,spread);
    float changeY = random(-spread,spread);
    PVector newP = new PVector(prevP.x + changeX, prevP.y + changeY);
    points.add(newP);
    prevP = newP;
  }
}

void drawCells() {
  if (points.size() > 0) {
     ArrayList<VPoint> pts = new ArrayList<VPoint>();
  
    for(int i = 0; i < points.size(); i++) {
      PVector p = points.get(i);
      
      VPoint vP = new VPoint(p, new PVector(W,H));
      pts.add(vP);
    }
    float[] col = {127,127,127};
    Cell cell = new Cell(pts, new PVector(W,H), col);
    cell.render(true); 
    
    float[] col2 = {255,255,255};
    
    int numCellsX = (int)(ceil(width/cellDistance))+2;
    int numCellsY = (int)(ceil(height/cellDistance))+2;
    
    for (int x = -numCellsX; x <= numCellsX; x++) {
       for (int y = -numCellsY; y < numCellsY; y++) {
         if (x != 0 || y != 0) {
           float moveX = cellDistance * x;
           float moveY = cellDistance * y;
           
           ArrayList<VPoint> pts2 = new ArrayList<VPoint>();
  
           for(int i = 0; i < points.size(); i++) {
              PVector p = points.get(i);

              
              VPoint vP = new VPoint(new PVector(p.x+moveX, p.y+moveY), new PVector(W,H));
              pts2.add(vP);
            }
            Cell cell2 = new Cell(pts2, new PVector(W,H), col2);
            cell2.render(false); 
          }
       }
    }
  }
}

void getOverlap() {
  int posX = (width - goalImg.width)/2;
  int posY = (height - goalImg.height)/2;
  PImage newImg = createImage(width, height, ARGB);
  newImg.loadPixels();
  
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int i = y*width + x;
      color newC = color(255,255,255,255);
      if (x >= posX && x < posX + goalImg.width && y >= posY && y < posY + goalImg.height) {
        color goalc = goalImg.get(x - posX, y - posY);
        color currentc = get(x,y);
        if (alpha(goalc) > 150 && red(currentc) < 180) {
          newC = color(0,0,0,255);
        } else if (red(currentc) < 180) {
          newC = color(150,150,150,255);
        } else if (alpha(goalc) > 150) {
          newC = color(200,200,200,255);
        }
      }
      newImg.pixels[i] = newC;
    }
  }
  newImg.updatePixels();
  image(newImg, 0, 0);  
}

int calculateFitness() {
  int good = 0;
  int extra = 0;
  int missing = 0;
  for (int x = 0; x < width; x++) {
     for (int y = 0; y < height; y++) {
       int value = (int)red(get(x,y));
       if (value == 0) {
         good++;
       } else if (value == 150) {
         extra++; 
       } else if (value == 200) {
         missing++; 
       }
     }
  }
  println("Good: " + good + " Extra: " + extra + " Missing: " + missing);
  int fitness = good - ((extra + missing)/2);
  println("Fitness: " + fitness);
  return fitness;
}

int getGoalFitness(float percent) {
  int count = 0;
  for (int x = 0; x < width; x++) {
     for (int y = 0; y < height; y++) {
       int value = (int)alpha(goalImg.get(x,y));
       if (value > 0) {
         count++;
       }
     }
  }
  return (int)(count * percent);
}
