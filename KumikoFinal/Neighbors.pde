/*
*Given a particular cell position, creates a list of neighboring cell positions
*@param i - current column number
*@param j - current row number
*@return - list of neighboring cell positions
*/
int[] getNeighborPositions(int i, int j) {
  int[] positions = new int[6];
  int n1row, n1col, n2row, n2col, n3row, n3col;
         
  if (j % 2 == 0 && i % 2 == 0) {
   n1row = j - 1;
   n1col = i;
   
   n2row = j;
   n2col = i + 1;
   
   n3row = j + 1;
   n3col = i;
  } else if (j % 2 == 0) {
   n1row = j - 1;
   n1col = i;
   
   n2row = j + 1;
   n2col = i;
   
   n3row = j;
   n3col = i - 1;
  } else if (i % 2 == 0) {
   n1row = j - 1;
   n1col = i;
 
   n2row = j + 1;
   n2col = i;
 
   n3row = j;
   n3col = i - 1;  
  } else {
   n1row = j - 1;
   n1col = i;
   
   n2row = j;
   n2col = i + 1;
   
   n3row = j + 1;
   n3col = i;
  }
  n1row = n1row < -1 ? rows - 2 : n1row > rows - 2 ? -1 : n1row;
  n2row = n2row < -1 ? rows - 2 : n2row > rows - 2 ? -1 : n2row;
  n3row = n3row < -1 ? rows - 2 : n3row > rows - 2 ? -1 : n3row;
   
  n1col = n1col < 0 ? cols - 1 : n1col > cols - 1 ? 0 : n1col;
  n2col = n2col < 0 ? cols - 1 : n2col > cols - 1 ? 0 : n2col;
  n3col = n3col < 0 ? cols - 1 : n3col > cols - 1 ? 0 : n3col;
         
  positions[0] = n1row;
  positions[1] = n1col;
  positions[2] = n2row;
  positions[3] = n2col;
  positions[4] = n3row;
  positions[5] = n3col;
  
  return positions;
}
