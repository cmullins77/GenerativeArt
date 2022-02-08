/*
* Cassie Mullins
* VIZA 654
* Created in Processing with Java
* 
* Applies various filters to selected images
* Blurs: 1 - Gaussian, 2 - Motion, 3 - Smart
* Edge Detection: 4 - Line Drawing, 5 - Emboss using Gray Scale, 6 - Emboss using Color
* Morphological: 7 - Dilation, 8 - Erosion, 9 - Heart Shaped Dilation, 0 - Heart Shaped Erosion
*/


PImage startImage = null;
PImage goalImage = null;

void setup() {
   colorMode(RGB, 1.0);
   background(0,0,0);
   size(600,600);
   surface.setResizable(true);
}

void draw() {
  if (startImage != null && goalImage != null) {
    stepImage();
  }
}

void keyPressed() {
  if (key == '1') {
    if (startImage == null) {
      selectInput("Select starting image", "selectStartImage");  
    } else {
      selectInput("Select new image", "selectNewImage");  
    }
  }
}

void selectStartImage(File selection) {
  startImage = loadImage(selection.getAbsolutePath());
  
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      set(x,y,startImage.get(x,y)); 
    }
  }
}

void selectNewImage(File selection) {
  goalImage = loadImage(selection.getAbsolutePath());
}

void stepImage() {
  boolean allCorrect = true;
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      color currCol = get(x,y);
      color goalCol = goalImage.get(x,y);
      float rGoal = red(goalCol);
      float rCurr = red(currCol);
      float rChange = random(-0.1,0.1);
      if (rGoal != rCurr) {
        rCurr += rChange;
      }
      
      float gGoal = green(goalCol);
      float gCurr = green(currCol);
      float gChange = random(-0.1,0.1);
      if (gGoal != gCurr) {
        gCurr += gChange;
      }
      
      float bGoal = blue(goalCol);
      float bCurr = blue(currCol);
      float bChange = random(-0.1,0.1);
      if (bGoal != bCurr) {
        bCurr += bChange;
      }
      
      set(x,y,color(rCurr, gCurr, bCurr));
      if (rCurr != rGoal || gCurr != gGoal || bCurr != bGoal) {
         allCorrect = false; 
      }
    } 
  }
  
  if (allCorrect) {
     startImage = goalImage;
     goalImage = null;
     print("FINISHED");
  }
} //<>// //<>// //<>//
