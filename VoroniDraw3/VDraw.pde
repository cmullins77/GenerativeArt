class VPoint {
    PVector pos;
    int S = 60;
    float R;
    float theta;
    float[] col;
    public VPoint(PVector p, PVector Size){
        R = dist(0,0,Size.x, Size.y);
        theta = radians(360)/S;
        pos = p;
    }
    
    void setColor(float[] c) {
      col = c;
    }
    
    void render(boolean mainCell) {
        //Translating coordinates
        pushMatrix();
        translate(pos.x, pos.y, 0);
        
        //Drawing a Cone (3D)
        fill(col[0], col[1], col[2]);
        beginShape(TRIANGLE_STRIP);
        for (int i = 0; i < S; i++) {
            vertex(0, 0, 0);
            vertex(R * cos(theta*i), R * sin(theta*i), -R);
            vertex(R * cos(theta*(i+1)), R * sin(theta*(i+1)), -R);
        }
        endShape();
        
        if (!hideSites) {
          //Drawing point at its center
          pushStyle();
          strokeWeight(8);
          stroke(mainCell ? 0 : 200);
          point(0, 0, 0);
          popStyle();
 
        }
        popMatrix();
    }
}

class VLine {
  
  VPoint p1, p2;
  float[] col;
  
  PVector size;
  
  public VLine(VPoint point1, VPoint point2, PVector Size) {
    p1 = point1;
    p2 = point2;
    size = Size;
  }
  
  void setColor(float[] c) {
      col = c;
  }
  
  void render(boolean mainCell) {
    float x1 = p1.pos.x;
    float x2 = p2.pos.x;
    float y1 = p1.pos.y;
    float y2 = p2.pos.y;
    float xDiff = x2 - x1;
    float yDiff = y2 - y1;
    
    float d = dist(0, 0, size.x, size.y);
    
    float ySlope = d;
    float xSlope = 0;
    if (ySlope != 0) {
      float slope = xDiff/yDiff * -1;
      float theta = atan(slope);
      ySlope = sin(theta)*d;
      xSlope = cos(theta)*d;
    }
    float newX1 = x1 + xSlope;
    float newY1 = y1 + ySlope;
    PVector newPos1 = new PVector(newX1,newY1,-d);
    
    float newX2 = x1 - xSlope;
    float newY2 = y1 - ySlope;
    PVector newPos2 = new PVector(newX2,newY2,-d);
    
    float newX3 = x2 + xSlope;
    float newY3 = y2 + ySlope;
    PVector newPos3 = new PVector(newX3,newY3,-d);
    
    float newX4 = x2 - xSlope;
    float newY4 = y2 - ySlope;
    PVector newPos4 = new PVector(newX4,newY4,-d);
    //Translating coordinates
    pushMatrix();
    translate(0,0,0);
    //Drawing a Tent
    fill(col[0], col[1], col[2]);
    beginShape();
    vertex(p1.pos.x,p1.pos.y,0);
    vertex(newPos1.x,newPos1.y,newPos1.z);
    vertex(newPos3.x,newPos3.y,newPos3.z);
    vertex(p2.pos.x, p2.pos.y,0);
    endShape();
    
    beginShape();
    vertex(p1.pos.x,p1.pos.y,0);
    vertex(newPos2.x,newPos2.y,newPos2.z);
    vertex(newPos4.x,newPos4.y,newPos4.z);
    vertex(p2.pos.x, p2.pos.y,0);
    endShape();
    
    if (!hideSites) {
      pushStyle();
      strokeWeight(2);
      stroke(mainCell ? 0 : 200);
      line(x1,y1,0,x2,y2,0);
      popStyle();
    }
    
    popMatrix();
  }
}

class Cell extends Object {
  
    ArrayList<VPoint> pts;
    ArrayList<VLine> lines;
    float[] col;
    
    public Cell(ArrayList<VPoint> points, PVector size, float[] c) {
        col = c;
        
        pts = points;
        VPoint p1 = pts.get(0);
        p1.setColor(col);
        
        lines = new ArrayList<VLine>();
        for (int i = 1; i < pts.size(); i++) {
          VPoint p2 = pts.get(i);
          p2.setColor(col);
          VLine l = new VLine(p1, p2, size);
          l.setColor(col);
          lines.add(l);
          p1 = p2;
        }
    }
            
    void render(boolean mainCell) { 
        for (VPoint p : pts) {
            p.render(mainCell);
        }
        for (VLine l : lines) {
            l.render(mainCell);
        }
    }
}
