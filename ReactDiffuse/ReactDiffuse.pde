PImage startImg;

color[][] pix;

void setup() {

    size(800,800);
    pix = new color[width][height];
    colorMode(RGB, 1);
    
    selectInput("Select an image to start with", "selectReactDiffuseStart"); 
}
    
void draw() {
  if (startImg != null) {
      reactDiffuse(); 
  }
}
        
void selectReactDiffuseStart(File file) {
    startImg = loadImage(file.getAbsolutePath());
    for(int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
         pix[x][y] = startImg.get(x,y);
      }
    }
}

void reactDiffuse() {
   //P layer1 = new color[width][height];
   //color[][] layer2 = new color[width][height];

    PImage layer1 = gaussianBlur(startImg, 2);
    PImage layer2 = gaussianBlur(startImg, 2);
    for (int i = 0; i < 3; i++) {
        layer2 = gaussianBlur(layer2, 2);
    }
    
    PImage subtracted = subtractImg(layer1, layer2);
    PImage exposed = exposure(subtracted);
    startImg = exposed;
    displayImg(startImg);
}

void displayImg(PImage pix) {
  for(int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
       set(x,y,pix.get(x,y)); 
    }
  }
}

PImage exposure(PImage img) {
  for(int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
       color col = img.get(x,y);
       if (red(col) != 0 || green(col) != 0 || blue(col) != 0) {
         img.set(x,y,color(1,1,1)); 
       } else {
         img.set(x,y,color(0,0,0));
       }
    }
  }
  return img;
}

//Given Image and filter radius, creates a gaussian blur
PImage gaussianBlur(PImage img, int filterRadius) {
  int N = filterRadius*2 + 1;
  
   //Calculate Weights
   float[][] weights = new float[N][N];
   float total = 0;
   for (int i = 0; i < N; i++) {
     for (int j = 0; j < N; j++) {
        float u = i - 0.5*(N-1);
        float v = j - 0.5*(N-1);
        float weight = exp(-1*((u*u + v*v)/(filterRadius*filterRadius)));
        weights[i][j] = weight;
        total += weight;
     }
   }
   //Scale Weights
   for (int i = 0; i < N; i++) {
     for (int j = 0; j < N; j++) {
       weights[i][j] = weights[i][j]/total;
     }
   }

  return blur(img, filterRadius, weights);
}

PImage blur(PImage img, int filterRadius, float[][] weights) {
  int N = filterRadius*2 + 1;
  PImage newImg = createImage(width, height, RGB);
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float red = 0;
      float green = 0;
      float blue = 0;
      
      //Calculate Filterd Colors
      for (int i = 0 ; i < N; i++) {
        for (int j = 0; j < N; j++) {
           float weight = weights[i][j];
           float u = x + i - 0.5*(N-1);
           float v = y + j - 0.5*(N-1);
           if (u < 0) {
             u = abs(u); 
           } else if (u >= width) {
             u = width - (u - width); 
           }
           if (v < 0) {
             v = abs(v); 
           } else if (v >= height) {
             v = height - (u - height); 
           }
           
           red = red + weight*red(img.get((int)u,(int)v));
           green = green + weight*green(img.get((int)u,(int)v));
           blue = blue + weight*blue(img.get((int)u,(int)v));
        }
      }
      newImg.set(x,y,color(red,green,blue));
    }
  }
  return newImg;
}


PImage subtractImg(PImage firstImg, PImage secondImg) {
  float alpha1 = 1;
  float alpha2 = 1;
  
  float newAlpha = alpha1 + alpha2*(1-alpha1);
  
  PImage newImg = createImage(width, height, RGB);
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float red =  red(firstImg.get(x,y)) * alpha1 - red(secondImg.get(x,y)) * alpha2 + red(secondImg.get(x,y))*(1-alpha1);
      float green =  green(firstImg.get(x,y)) * alpha1 - green(secondImg.get(x,y)) * alpha2 + green(secondImg.get(x,y))*(1-alpha1);
      float blue =  blue(firstImg.get(x,y)) * alpha1 - blue(secondImg.get(x,y)) * alpha2 + blue(secondImg.get(x,y))*(1-alpha1);
      
      newImg.set(x,y,color(red,green,blue, newAlpha));
    }
  }
  return newImg;
}
