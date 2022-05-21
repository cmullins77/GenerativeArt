File[] files;
int num = 0;

void setup() {
  File folder = new File("C:/Users/mulli/OneDrive/Documents/GitHub/GenerativeArt/CellAutomataTest7/New folder (3)/Good/Bookmarks/ToCombine"); 
  files = folder.listFiles();
  size(3000,2000);
}

void draw() {
  int border = 50;
  PImage img1 = loadImage(files[num].getPath());
  PImage img2 = loadImage(files[num+1].getPath());
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < img1.height; y++) {
      color c = img1.get(x,y);
      if (x < border || x >= width - border || y < border || y >= img1.height - border) {
        c = color(255); 
      }
      set(x,y,c); 
    }
    for (int y = 0; y < img2.height; y++) {
      color c = img2.get(x,y);
      if (x < border || x >= width - border || y < border || y >= img2.height - border) {
        c = color(255); 
      }
      set(x,y+img1.height, c); 
    }
  }
  save(num+".png");
  num += 2;
  if (num >= files.length) {
    exit(); 
  }
}
