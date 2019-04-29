PGraphics pg, pg2;
PImage img2,img1,img;
/*float[][] matrix = { { -1, -1, -1 },
                     { -1,  8, -1 },
                     { -1, -1, -1 } };
/* float[][] matrix = { { 0, -1, 0 },
                     { -1,  5, -1 },
                     { 0, -1, 0 } };
float[][] matrix = { { 0.1111, 0.1111, 0.1111 },
                     { 0.1111,  0.1111, 0.1111 },
                     { 0.1111, 0.1111,0.1111 } };*/
 float[][] matrix = { { 0.0625, 0.125, 0.0625 },
                     { 0.125,  0.25, 0.125 },
                     { 0.0625, 0.125,0.0625 } };
void setup() {
  size(410, 200);
  pg = createGraphics(200, 200);
  pg2 = createGraphics(200, 200);
  img1 = loadImage("baboon.png");
  img2 = loadImage("lena.png");
  img2.resize(200,200);
  img1.resize(200,200);
}
void draw() {
  
  img = img1;
  int matrixsize = 3;
  pg.beginDraw();
  pg.background(100);
  pg.image(img,0,0,200,200);
  pg.endDraw();
  pg.loadPixels();
  pg2.beginDraw();
  pg2.loadPixels();
  for (int x = 0; x < pg.width; x++) {
    for (int y = 0; y < pg.height; y++ ) {
      color c = convolution(x, y, matrix, matrixsize, img);
      int loc = x + y*pg.width;
      pg2.pixels[loc] = c;
    }
  }
  pg2.updatePixels();
  pg2.endDraw();
  image(pg, 0, 0);
  image(pg2,210,0);
}
color convolution(int x, int y, float[][] matrix, int matrixsize, PImage img)
{
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int offset = matrixsize / 2;
  for (int i = 0; i < matrixsize; i++){
    for (int j= 0; j < matrixsize; j++){
      int xloc = x+i-offset;
      int yloc = y+j-offset;
      int loc = xloc + img.width*yloc;
      loc = constrain(loc,0,img.pixels.length-1);
      rtotal += (red(img.pixels[loc]) * matrix[i][j]);
      gtotal += (green(img.pixels[loc]) * matrix[i][j]);
      btotal += (blue(img.pixels[loc]) * matrix[i][j]);
    }
  }
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  return color(rtotal, gtotal, btotal);
}
