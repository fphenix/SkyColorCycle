
int NBLAYERS = 5;
int NBHOURS = 24;
int NBCOLORP = 3;
float HOURSTEP = 0.02;
int SPEED = 1;
int BLUE = 0;
int GREEN = 1;
int RED = 2;

//int[NBLAYERS][NBCOLORP][NBHOURS]; Indices:
//NBLAYERS: layer nb (0 to 4)
//NBCOLORP: color parameter (red=2, green=1 or blue=0)
//NBHOURS:hour 0 to 23 (24 wraps back to 0)
int[][][] Layer = { 
  {
    { 72, 74, 77, 79, 89, 99, 173, 242, 246, 251, 255, 255, 255, 255, 255, 239, 223, 64, 25, 49, 72, 96, 119, 96}, 
    { 28, 32, 36, 40, 66, 91, 127, 204, 215, 225, 236, 239, 241, 232, 222, 207, 192, 125, 28, 32, 36, 39, 43, 36}, 
    { 39, 38, 36, 35, 101, 166, 208, 161, 162, 163, 164, 174, 183, 174, 164, 174, 183, 251, 178, 150, 122, 93, 65, 52}
  }, 
  {
    { 91, 89, 87, 85, 96, 106, 178, 255, 255, 255, 255, 255, 255, 255, 255, 235, 215, 40, 26, 44, 63, 81, 99, 95}, 
    { 27, 31, 34, 38, 52, 66, 96, 195, 206, 218, 229, 233, 237, 231, 224, 199, 174, 72, 8, 15, 22, 28, 35, 31}, 
    { 39, 43, 47, 51, 107, 163, 208, 141, 140, 139, 138, 154, 170, 144, 117, 141, 165, 209, 192, 158, 125, 91, 57, 48}
  }, 
  {
    { 96, 96, 96, 96, 90, 84, 141, 255, 255, 255, 255, 255, 255, 255, 255, 221, 186, 69, 52, 63, 75, 86, 97, 97}, 
    { 26, 29, 32, 35, 42, 49, 62, 182, 196, 209, 223, 226, 229, 224, 219, 181, 143, 34, 2, 8, 14, 20, 26, 26}, 
    { 34, 43, 53, 62, 116, 170, 200, 109, 111, 114, 116, 123, 130, 116, 102, 130, 158, 211, 195, 161, 127, 93, 59, 47}
  }, 
  {
    { 98, 99, 101, 102, 108, 114, 206, 255, 255, 255, 255, 255, 255, 255, 255, 232, 208, 77, 80, 91, 103, 114, 125, 112}, 
    { 26, 27, 29, 30, 33, 36, 45, 183, 197, 210, 224, 225, 226, 224, 221, 170, 118, 24, 1, 6, 11, 15, 20, 23}, 
    { 34, 42, 50, 58, 90, 122, 146, 71, 87, 103, 119, 122, 124, 116, 108, 124, 139, 176, 180, 148, 115, 83, 50, 42}
  }, 
  {
    { 80, 86, 92, 98, 112, 126, 225, 255, 255, 255, 255, 255, 255, 255, 255, 241, 227, 130, 157, 146, 135, 123, 112, 96}, 
    { 26, 27, 29, 30, 32, 34, 45, 184, 196, 207, 219, 222, 224, 222, 219, 167, 114, 21, 0, 4, 8, 12, 16, 21}, 
    { 30, 32, 34, 36, 43, 50, 58, 69, 80, 91, 102, 107, 112, 108, 104, 100, 96, 130, 134, 109, 84, 59, 34, 32}
  }
};

// int[NBCOLORP][NBHOURS]; Indices: see above.
int[][]   Astre = { 
  {254, 253, 253, 252, 244, 236, 228, 225, 223, 220, 217, 215, 212, 199, 186, 173, 159, 146, 133, 120, 165, 210, 255, 255}, 
  {229, 237, 246, 254, 249, 245, 240, 243, 245, 248, 250, 253, 255, 248, 240, 233, 226, 219, 211, 204, 219, 233, 248, 239}, 
  {187, 209, 232, 254, 254, 253, 253, 253, 254, 254, 254, 255, 255, 255, 255, 255, 255, 255, 255, 255, 254, 252, 251, 219}
};

float hour = 0.0;
int elevationstep;

void setup ()
{
  size(800, 480);
  colorMode(RGB);
  ellipseMode(CENTER);
  elevationstep = int(height / (NBLAYERS -1));
}

void draw () {
  int h = int(hour);
  int hP1 = int(h+1);
  if (hP1 >= NBHOURS) {
    hP1-=NBHOURS;
  }
  float angle;
  float radius;
  int r, g, b;

  for (int elevation = 0; elevation < height; elevation++) {
    float r1, g1, b1;
    float r2, g2, b2;

    int layernb = int(float(elevation) / float(elevationstep));
    int layernbP1 = layernb + 1;
    float normElevation = (elevation == 0) ? 0 : (float(elevation*(NBLAYERS-1))/float(height));

    //Sky line color; function of the elevation and the hour
    r1 = LinearInterpolate(normElevation, layernb, Layer[layernb][RED][h], layernbP1, Layer[layernbP1][RED][h]);
    g1 = LinearInterpolate(normElevation, layernb, Layer[layernb][GREEN][h], layernbP1, Layer[layernbP1][GREEN][h]);
    b1 = LinearInterpolate(normElevation, layernb, Layer[layernb][BLUE][h], layernbP1, Layer[layernbP1][BLUE][h]);
    r2 = LinearInterpolate(normElevation, layernb, Layer[layernb][RED][hP1], layernbP1, Layer[layernbP1][RED][hP1]);
    g2 = LinearInterpolate(normElevation, layernb, Layer[layernb][GREEN][hP1], layernbP1, Layer[layernbP1][GREEN][hP1]);
    b2 = LinearInterpolate(normElevation, layernb, Layer[layernb][BLUE][hP1], layernbP1, Layer[layernbP1][BLUE][hP1]);

    r = LinearInterpolate(hour, h, int(r1), hP1, int(r2));
    g = LinearInterpolate(hour, h, int(g1), hP1, int(g2));
    b = LinearInterpolate(hour, h, int(b1), hP1, int(b2));
    //draw sky line
    stroke(int(r), int(g), int(b));
    line(0, height-elevation, width-1, height-elevation);
  }

  //Sun/Moon color, function of the hour
  r = LinearInterpolate(hour, h, Astre[RED][h], hP1, Astre[RED][hP1]);
  g = LinearInterpolate(hour, h, Astre[GREEN][h], hP1, Astre[GREEN][hP1]);
  b = LinearInterpolate(hour, h, Astre[BLUE][h], hP1, Astre[BLUE][hP1]);

  int centerx = 400;
  int centery;
  int x, y;
  x = -100;
  y = -100;
  noStroke();
  //draw sun/moon
  if ((hour >= 5.0) && (hour <= 21.0)) {
    //Sun
    radius = 225.0;
    centery = -80;
    angle = PI - ((hour - 5.0) * (PI / (21.0 - 5.0)));
    x = int((radius * (1+sin(angle))) * cos(angle)) + centerx;
    y = height - (int((radius * (1+sin(angle))) * sin(angle)) + centery);
    fill(int(r), int(g), int(b));
    ellipse(x, y, 80, 80);
  }
  if ((hour >= 22.0) || (hour <= 4.0)) {
    //Moon
    float hourmod = (hour <= 4.0) ? (hour + 24.0) : hour;
    radius = 210.0;
    centery = -150;
    angle = PI - ((hourmod - 22.0) * (PI / (29.0 - 22.0)));
    x = int((radius * (1+sin(angle))) * cos(angle)) + centerx;
    y = height - (int((radius * (1+sin(angle))) * sin(angle)) + centery);
    //fill(20);
    ellipse(x, y, 80, 80);
    //fill(int(r), int(g), int(b));
    //arc(x, y, 80, 80, PI/2,3*PI/2);
  }

  //next hour
  hour+=HOURSTEP;
  if (hour >= float(NBHOURS)) {
    hour = 0.0;
  }
}

int LinearInterpolate (float x, int x1, int y1, int x2, int y2) {
  float a = float(y2 - y1) / float(x2 - x1);
  float b = (float(x2*y1) - float(x1*y2)) / float(x2 -x1);
  return int(a*x+b);
}
