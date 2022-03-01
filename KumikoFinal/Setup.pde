/*
*Function that sets up the variables needed for the automata 
*/
void prepareVariables() {
  //cols = (int)rand(rand(4,12,0.5), rand(12,25,2), 1);
  cols = (int)random(4,25);
  
  if (width > 1200) {
     cols *= 2;
  }
  
  w = width/(cols*1.0);
  triangleSize = (w/cos(radians(30)));
  
  rows = (int)(height/(triangleSize/2) + 2);
  if (rows % 2 != 0) {
     rows++; 
  }
  
  totalPatterns = 20;
  numPatterns = (int)rand(3,totalPatterns+1, 3);
  
  chosenRuleSet = (int)random(0,ruleOptions.length);
  ruleSet = ruleOptions[chosenRuleSet]; 
  
  framerate = 15 - cols;
  framerate = framerate < 1 ? 1 : framerate;
  
  if (cols <= 15) {
    framerate = -cols + 20; 
  } else if (cols <= 21) {
    framerate = (int)(-0.5*cols + 12); 
  } else {
    framerate = 1;
  }
  frameRate(12);
  println(cols + " " + framerate);
  //framesPerSection = (int)rand(rand(650,1000,.5), rand(1000,1500,2), 1);
  framesPerSection = (int)rand(rand(250,600,.5), rand(600,1000,2), 1);
  //framesPerSection = 100;
  
  println("Columns: " + cols + " & Rows: " + rows + "\nNum Pattterns: " + numPatterns + 
  ", Rule Set: " + chosenRuleSet + ", Frame Rate: " + framerate + ", Frames Per: " + framesPerSection);
}

/*
*Function that runs each time the automata changes, setting up the new grid and patterns and colors
*/
void automataSetup() {
  prepareVariables();
  
  background(255);
  color strokeColor = color(random(0,256), random(0,180), random(0,256));
  while(saturation(strokeColor) < 50 && brightness(strokeColor) > 200) {
    strokeColor = color(random(0,256), random(0,180), random(0,256));
  }
  stroke(strokeColor);

  colors = new int[cols][rows];
  for (int j = 0; j < rows; j++) {
    int col = (int)random(-1 * (numPatterns - 1),numPatterns);
    if (!useRandomStart) {
      col = 0;
      if (j == rows/2) {
        col = numPatterns - 1; 
      }
    }
    colors[0][j] = col;
  }
  
  for (int i = 1; i < cols; i++) {
     for (int j = 0; j < rows; j++) {
        colors[i][j] = 0;
     }
  }
  
  pList = new IntList();
  for (int i = 0; i < totalPatterns; i++) {
    pList.append(i); 
  }
  pList.shuffle();
  
  if (showStart) {
    drawTriangles(true); 
  } else {
    for (int i = 0; i < cols*2; i++) {
        drawTriangles(true);
    }
  }
}

/*
*Reads in the Rules.txt file, creating a list of all the possible automata
*/
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
   ruleSet = ruleOptions[chosenRuleSet];
}
