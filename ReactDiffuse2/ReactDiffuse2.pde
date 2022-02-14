PImage startImg;
int imgNum =0;

color[][] pix;

void setup() {

    size(1000,600);
    pix = new color[width][height];
    colorMode(RGB, 1);
    
    selectInput("Select an image to start with", "selectReactDiffuseStart"); 
}
    
void draw() {
  if (startImg != null) {
      reactDiffuse(); 
      save(imgNum + ".jpg");
      imgNum++;
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

    PImage blurred = gaussianBlur(startImg, 7);
    
    //displayImg(blurred);
    //save("Blurred.jpg");
    
    PImage blurredHighPass = gaussianBlur(blurred, 6);
    //displayImg(blurredHighPass);
    //save("BlurredHighPass.jpg");
    PImage highPass = grainExtract(blurredHighPass, blurred);
    highPass = gaussianBlur(highPass, 3);
    
    //displayImg(highPass);
    //save("HighPass.jpg");

    startImg = threshold(highPass);
    
    displayImg(startImg);
    //save("Threshold.jpg");
    //startImg = null;
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

PImage grainExtract(PImage firstImg, PImage secondImg) {
  PImage newImg = createImage(width, height, RGB);
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      color col1 = firstImg.get(x,y);
      color col2 = secondImg.get(x,y);
      float red = red(col2) - red(col1) + 0.5;
      float green = green(col2) - green(col1) + 0.5;
      float blue = blue(col2) - blue(col1) + 0.5;
      newImg.set(x,y,color(red,green,blue));
    }
  }
  return newImg;
}

PImage threshold(PImage img) {
  for(int x = 0; x < width; x++) {
     for (int y = 0; y < height; y++) {
        color col = img.get(x,y);
        float r = red(col);
        float g = green(col);
        float b = blue(col);
        
        if (r <= 0.49){
          r = 0;
        } else {
          r = 1;
        }
        
        if (g <= 0.49){
          g = 0;
        } else {
          g = 1;
        }
        
        if (b <= 0.49){
          b = 0;
        } else {
          b = 1;
        }
        
        img.set(x,y,color(r,g,b));
     }
  }
  return img;
}
