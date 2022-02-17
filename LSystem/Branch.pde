class Branch {
  public float len;
  public float angle;
  PVector position;
  PVector direction;
  
  public Branch(float l, float a, PVector p, PVector d) {
    len = l;
    angle = a;
    position = p;
    direction = d;
  } 
  
  public Branch drawNext() {
    float x0 = position.x;
    float y0 = position.y;
  }
}
