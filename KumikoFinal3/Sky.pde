color[] botCols = {color(242, 131, 142),
color(212, 175, 55), 
color(191, 232, 255),
color(111, 182, 222),
color(230, 145, 34),
color(191, 112, 94),
color(15, 17, 77),
color(17, 17, 48)};
color[] topCols = {color(85, 52, 110),
color(195, 225, 253),
color(112, 176, 212),
color(63, 158, 212),
color(146, 60, 199),
color(57, 38, 148), 
color(1, 2, 36),
color(5, 5, 28)};
int transition = 50;
int[] lenghtTime = {600, 600, 1000, 1000, 600, 600, 800, 800};
float timeModifier = 0.2;

int skyframe = 0;
int prevChange = 0;
int nextChange = (int)(lenghtTime[0]*timeModifier);
int section = 0;
int next = 1;

color getBackgroundColor(int y, boolean animated) {
  colorMode(RGB, 255); //<>//
  if (animated) {
    float positT =  (float)y/height;
    float timeT = (skyframe - (float)prevChange)/(nextChange - prevChange);
    color bottom = color(lerp(red(botCols[section]), red(botCols[next]), timeT), 
    lerp(green(botCols[section]), green(botCols[next]), timeT), 
    lerp(blue(botCols[section]), blue(botCols[next]), timeT));
    color top = color(lerp(red(topCols[section]), red(topCols[next]), timeT), 
    lerp(green(topCols[section]), green(topCols[next]), timeT), 
    lerp(blue(topCols[section]), blue(topCols[next]), timeT));
    
    color mix = color(lerp(red(top), red(bottom), positT), lerp(green(top),
    green(bottom), positT), lerp(blue(top), blue(bottom), positT));
    
    return mix;
  } else {
    color c0 = color(195, 225, 253);
    color c1 = color(212, 175, 55);
    float t = ((float)y)/height;
    return color(lerp(red(c0), red(c1), t), lerp(green(c0), green(c1), t), lerp(blue(c0), blue(c1), t));
  }
}

void updateBackground() {
  skyframe++;
  if (skyframe == nextChange) {
    prevChange = nextChange;
    nextChange += (lenghtTime[next]*timeModifier); 
    section = section == botCols.length - 1 ? 0 : section + 1;
    next = section == botCols.length - 1 ? 0 : section + 1;
  } 
}
