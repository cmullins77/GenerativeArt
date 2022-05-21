PrintWriter output;
int frame = 0;
void setup() {
  output = createWriter("Colors.txt"); 
  size(800,800); 
}

void keyPressed() {
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  exit(); // Stops the program
}

void draw() {
   int numColors = (int)random(5, 20);
   int size = height/numColors;
   String setString = frame + ":";
   for (int i = 0; i < numColors; i++) {
     int currHeight = size;
     if (i == numColors - 1) {
       currHeight += (height - size*numColors); 
     }
     color c = color(random(256), random(256), random(256));
     setString += red(c) + "," + green(c) + "," + blue(c);
     if (i < numColors - 1) {
       setString += " "; 
     }
     fill(c);
     noStroke();
     rect(0, size*i, width, size*i + currHeight);
   }
   output.println(setString);
   frame++;
}
