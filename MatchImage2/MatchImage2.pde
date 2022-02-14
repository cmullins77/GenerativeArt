public class Line {
  float x1, x2, y1, y2;
  public Line(float thisx1, float thisy1, float thisx2, float thisy2) {
    x1 = thisx1;
    x2 = thisx2;
    y1 = thisy1;
    y2 = thisy2;
  }
}

PImage goalImage;

ArrayList<Line> lineList1 = new ArrayList<Line>();
ArrayList<Line> lineList2 = new ArrayList<Line>();
int result1 = -1;
int result2 = -1;
int numLines = 500;

int imgNum = 0;

void setup() {
  colorMode(RGB, 1.0);
  background(1);
  size(600,600);
  selectInput("Select starting image", "selectGoalImage");
}

void draw() {
  
}

void keyPressed() {
   println(key); 
   
   if (result1 == -1) {
     generateRandomLines();
   } else {
     for (int i = 0; i < 500; i++) {
       generateNewLines();
       imgNum = 0;
     }
   }
}

void selectGoalImage(File selection) {
  goalImage = loadImage(selection.getAbsolutePath());
}

void generateRandomLines() {
  for (int i = 0; i < numLines; i++) {
    float x = random(0,width);
    float y = random(0,height);
    Line l = new Line(x + random(-20,20), y + random(-20,20), x + random(-20,20), y + random(-20,20));
    lineList1.add(l);
    line(l.x1, l.y1, l.x2, l.y2);
  }
  result1 = 0;
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      color goal = goalImage.get(x,y);
      float gr = red(goal);
      float gg = green(goal);
      float gb = blue(goal);
      
      float curr = red(get(x,y));
      
      float diff = abs(gr - curr) + abs(gg - curr) + abs(gb - curr);
 
      result1 += diff;
    }
  }
  println(result1);
  save(imgNum + ".jpg");
  imgNum++;
  background(1);
  for (int i = 0; i < numLines; i++) {
    float x = random(0,width);
    float y = random(0,height);
    Line l = new Line(x + random(-20,20), y + random(-20,20), x + random(-20,20), y + random(-20,20));
    lineList2.add(l);
    line(l.x1, l.y1, l.x2, l.y2);
  }
  result2 = 0;
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      color goal = goalImage.get(x,y);
      float gr = red(goal);
      float gg = green(goal);
      float gb = blue(goal);
      
      float curr = red(get(x,y));
      
      float diff = abs(gr - curr) + abs(gg - curr) + abs(gb - curr);
 
      result2 += diff;
    }
  }
  println(result2);
  save(imgNum + ".jpg");
  imgNum++;
}

void generateNewLines() {
  ArrayList<Line> lineList = lineList1;
  if (result2 < result1) {
     lineList = lineList2; 
  }
  
  lineList1 = new ArrayList<Line>();
  lineList2 = new ArrayList<Line>();
  for (int i = 0; i < numLines; i++) {
     Line oldL = lineList.get(i);
     Line l = new Line(oldL.x1, oldL.y1, oldL.x2, oldL.y2);
     l.x1 += random(-10,10);
     l.x2 += random(-10,10);
     l.y1 += random(-10,10);
     l.y2 += random(-10,10);
     lineList1.add(l);
     line(l.x1, l.y1, l.x2, l.y2);
  }
  result1 = 0;
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      color goal = goalImage.get(x,y);
      float gr = red(goal);
      float gg = green(goal);
      float gb = blue(goal);
      
      float curr = red(get(x,y));
      
      float diff = abs(gr - curr) + abs(gg - curr) + abs(gb - curr);
 
      result1 += diff;
    }
  }
  println(result1);
  save(imgNum + ".jpg");
  imgNum++;
  background(1);
  
  for (int i = 0; i < numLines; i++) {
     Line oldL = lineList.get(i);
     Line l = new Line(oldL.x1, oldL.y1, oldL.x2, oldL.y2);
     l.x1 += random(-10,10);
     l.x2 += random(-10,10);
     l.y1 += random(-10,10);
     l.y2 += random(-10,10);
     lineList2.add(l);
     line(l.x1, l.y1, l.x2, l.y2);
  }
  result2 = 0;
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      color goal = goalImage.get(x,y);
      float gr = red(goal);
      float gg = green(goal);
      float gb = blue(goal);
      
      float curr = red(get(x,y));
      
      float diff = abs(gr - curr) + abs(gg - curr) + abs(gb - curr);
 
      result2 += diff;
    }
  }
  println(result2);
  save(imgNum + ".jpg");
  imgNum++;
}
/*
    
def generateRandomLists():
    global numLines
    for i in range(numLines):
        print(i)
        line(random(0,width), random(0, height), random(0,width), random(0,height))*/
    
