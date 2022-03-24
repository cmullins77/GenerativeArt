ArrayList<PVector> circs = new ArrayList<PVector>();

void setup() {
  size(600,600);
  //noStroke();
  //background(0);
  for (int i = 0; i < 5; i++) {
      drawFrac((int)random(100,500),(int)random(100,500),(int)random(60,150)); 
  }
}

void draw() {
   if (circs.size() > 0) {
     int num = circs.size() < 10 ? circs.size() : 10;
     
     for (int i = 0; i < num; i++) {
       PVector c = circs.get(0);
       circle(c.x,c.y,c.z);
       circs.remove(0); 
     }
   }
}



void drawFrac(int x, int y, int r) {
  if (r < 2) {
    return;
  }
  circs.add(new PVector(x,y,r*2));
  int num = (int)random(2,8);
  for (int i = 0; i < num; i++) {
     int rad = (int)(r*0.6);
     float t = random(0, 2*PI);
     int newX = (int)(cos(t)*r + x);
     int newY = (int)(sin(t)*r + y);
     drawFrac(newX,newY,rad);
  }
  //drawFrac(x+r,y,r/2);
  //drawFrac(x-r,y,r/2);
  //drawFrac(x,y+r,r/2);
  //drawFrac(x,y-r,r/2);
  //circle(x,y,r*2);

}
