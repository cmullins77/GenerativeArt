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

void setup(){
  size(1400, 900, P3D);
  ortho(-W>>1, W>>1, -H>>1, H>>1);
  noStroke();
  background(255);
  selectInput("Select a Goal Image:", "selectGoal");
}

void selectGoal(File selection) {
  goalImg = loadImage(selection.getAbsolutePath()); 
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
  } else if (key == 'p') {
    hideSites = !hideSites;
  } else if (key == 'e') {
    imgDisplayMode++;
  }
}

void draw() {
  background(255);
  fill(0);
  
  if (moveDots && dotMoving != -1) {
    PVector p = points.get(dotMoving);
    points.remove(p);
    p.x = mouseX;
    p.y = mouseY;
    points.add(dotMoving, p);
  }
  if (showingVoronoi) {
    if (points.size() > 0) {
       ArrayList<VPoint> pts = new ArrayList<VPoint>();
    
      for(int i = 0; i < points.size(); i++) {
        PVector p = points.get(i);
        
        VPoint vP = new VPoint(p, new PVector(W,H));
        pts.add(vP);
      }
      float[] col = {127,127,127};
      Cell cell = new Cell(pts, new PVector(W,H), col); //<>//
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
  } else {
    renderWithoutVoronoi();
  }
  
  fill(255,0,0);
  circle(mouseX, mouseY, 20);
  
  if (goalImg != null) {
    if (imgDisplayMode % 3 == 1) {
      float posX = (width - goalImg.width)/2;
      float posY = (height - goalImg.height)/2;
      PImage newImg = createImage(goalImg.width, goalImg.height, ARGB);
      newImg.loadPixels();
      
      for (int i = 0; i < newImg.pixels.length; i++) {
        color c = goalImg.pixels[i];
        color newC = color(255,0,0,alpha(c)*0.75);
        newImg.pixels[i] = newC;
      }
      newImg.updatePixels();
      image(newImg, (int)posX, (int)posY);  
    } else if (imgDisplayMode % 3 == 2) {
      float posX = (width - goalImg.width)/2;
      float posY = (height - goalImg.height)/2;
      PImage newImg = createImage(goalImg.width, goalImg.height, ARGB);
      newImg.loadPixels();
      
      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          int i = y*width + x;
          color goalc = goalImg.pixels[i];
          
          color newC = color(255,255,255,255);
          if (x >= posX && x < posX + goalImg.width && y >= posY && y < posY + goalImg.height) {
            color currentc = get(x,y);
            if (alpha(goalc) > 150 && red(currentc) < 180) {
              newC = color(0,0,0,255);
            }
          }
          newImg.pixels[i] = newC;
        }
      }
      newImg.updatePixels();
      image(newImg, (int)posX, (int)posY);  
    }
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
