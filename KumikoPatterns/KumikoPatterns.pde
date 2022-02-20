PVector[] points = new PVector[3];

void setup() {
  size(800,800);
  stroke(0);
  background(255);
  
  float h = 600;
  float w = (int)(h/cos(radians(30)));
  
  PVector m = new PVector(400,400);
  strokeWeight(8);
  points[0] = new PVector(m.x, m.y - h/2);
  points[1] = new PVector(m.x + w/2, m.y + h/2);
  points[2] = new PVector(m.x - w/2, m.y + h/2);
  triangle(m.x, m.y - h/2, m.x + w/2, m.y + h/2, m.x - w/2, m.y + h/2);
}

void draw() {
  //drawPattern15(points);
  save("Pattern.jpg");
  noLoop(); 
}

void drawPattern15(PVector[] verts) {
  float percent = 0.65;
  strokeWeight(6);
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
  strokeWeight(6);
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
  strokeWeight(6);
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
  strokeWeight(6);
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
  
  strokeWeight(6);
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
  strokeWeight(6);
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
    
    strokeWeight(6);
    
    PVector p0 = new PVector(prevP.x*percent1 + currP.x*(1-percent1), prevP.y*percent1 + currP.y*(1-percent1));
    PVector p1 = new PVector(nextP.x*percent1 + currP.x*(1-percent1), nextP.y*percent1 + currP.y*(1-percent1));
    line(p0.x,p0.y,p1.x,p1.y);
    
    strokeWeight(6);
    
    PVector p2 = new PVector((p0.x + p1.x)/2, (p0.y + p1.y)/2);
    line(p2.x, p2.y, center.x, center.y);
    
    PVector p3 = new PVector(prevP.x*percent2 + currP.x*(1-percent2), prevP.y*percent2 + currP.y*(1-percent2));
    PVector p4 = new PVector(nextP.x*percent2 + currP.x*(1-percent2), nextP.y*percent2 + currP.y*(1-percent2));
    line(p3.x,p3.y,p4.x,p4.y);
  }
}

void drawPattern11(PVector[] verts) {
  PVector m = new PVector((verts[0].x + verts[1].x + verts[2].x)/3,(verts[0].y + verts[1].y + verts[2].y)/3) ;
  strokeWeight(6);
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
  strokeWeight(6);
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
  
  strokeWeight(6);
  line(p0.x, p0.y, p1.x, p1.y);
  line(p2.x, p2.y, p3.x, p3.y);
}

void drawPattern8(PVector[] verts) {
  PVector p0 = verts[0];
  PVector p1 = new PVector((verts[1].x*2 + verts[2].x)/3, (verts[1].y*2 + verts[2].y)/3);
  PVector p2 = new PVector((verts[1].x + verts[2].x)/2, (verts[1].y + verts[2].y)/2);
  PVector p3 = new PVector((verts[1].x + verts[2].x*2)/3, (verts[1].y + verts[2].y*2)/3);
  strokeWeight(6);
  line(p0.x, p0.y, p1.x, p1.y);
  line(p0.x, p0.y, p2.x, p2.y);
  line(p0.x, p0.y, p3.x, p3.y);
}

void drawPattern7(PVector[] verts) {
  PVector p0 = verts[0];
  PVector p1 = new PVector((verts[1].x*2 + verts[2].x)/3, (verts[1].y*2 + verts[2].y)/3);
  strokeWeight(6);
  line(p0.x, p0.y, p1.x, p1.y);
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
