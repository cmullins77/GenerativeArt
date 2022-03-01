/*
*Function that draws the current grid of triangles and the correct patterns and then generates the next column
*/
void drawTriangles(boolean update) {
   for (int i = 0; i < cols; i++) {
      for (int j = -1; j < rows-1; j++) {
         int currColor = colors[i][j+1];
         
         PVector[] vertices = getTriangleVertices(i,j);
         strokeWeight(6);
         
         triangle(vertices[0].x,vertices[0].y,vertices[1].x,vertices[1].y,vertices[2].x,vertices[2].y);
         
         drawPattern(vertices, currColor);
     }
   }
   if (update) {
     int[][] nextIter = new int[cols][rows];
     for (int i = 1; i < cols; i++) {
       nextIter[i] = colors[i-1]; 
     }
     nextIter[0] = getNextCol(nextIter[1]);
     colors = nextIter;
   }
   
   if (useWood) {
     for (int x  = 0; x < width; x++) {
       for (int y = 0; y < height; y++) {
         if (brightness(get(x,y)) != 0) {
           set(x,y,woodImg.get(x,y)); 
         } else {
           set(x,y, getBackgroundColor(y, animatedSky)); 
         }
       }
     }
     updateBackground();
   }
}

/*
* Given the column and row calculates the vertices of a triangle
*@param i - current column
*@param j - current row
*@return - List of Triangle's vertices
*/
PVector[] getTriangleVertices(int i, int j) {
   PVector[] vertices = new PVector[3];
   int x1 = (int)(i * w);
   float y1 = triangleSize/2 * (j+1);
   
   int x2 = (int)((i + 1) * w);
   float y2 = triangleSize/2 * j;
   
   int x3 = (int)((i + 1) * w);
   float y3 = triangleSize/2 * (j+2);
   
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
