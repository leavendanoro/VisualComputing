import processing.video.*;
PGraphics pg, pg2;
Movie movie;
float[][] matrix = { { -1, -1, -1 },
                     { -1,  8, -1 },
                     { -1, -1, -1 } };
/* float[][] matrix = { { 0, -1, 0 },
                     { -1,  5, -1 },
                     { 0, -1, 0 } };
float[][] matrix = { { 0.1111, 0.1111, 0.1111 },
                     { 0.1111,  0.1111, 0.1111 },
                     { 0.1111, 0.1111,0.1111 } };
 float[][] matrix = { { 0.0625, 0.125, 0.0625 },
                     { 0.125,  0.25, 0.125 },
                     { 0.0625, 0.125,0.0625 } };*/
void setup() {
  size(410, 200);
  pg = createGraphics(200, 200);
  pg2 = createGraphics(200, 200);
  movie = new Movie(this, "xmas.mp4");
  movie.loop();
}
void movieEvent(Movie m) {
  m.read();
}
void draw() {
  int matrixsize = 3;
  pg.beginDraw();
  pg.background(100);
  pg.image(movie,0,0,200,200);
  pg.endDraw();
  pg2.beginDraw();
  pg2.loadPixels();
  pg2.background(100);
  for (int x = 0; x < pg.width; x++) {
    for (int y = 0; y < pg.height; y++ ) {
      color c = convolution(x, y, matrix, matrixsize, pg);
      int loc = x + y*pg.width;
      pg2.pixels[loc] = c;
    }
  }
  pg2.updatePixels();
  
  pg2.endDraw();
  image(pg, 0, 0);
  image(pg2,210,0);
  println(frameRate);
}
color convolution(int x, int y, float[][] matrix, int matrixsize, PGraphics pg)
{
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int offset = matrixsize / 2;
  for (int i = 0; i < matrixsize; i++){
    for (int j= 0; j < matrixsize; j++){
      int xloc = x+i-offset;
      int yloc = y+j-offset;
      int loc = xloc + pg.width*yloc;
      loc = constrain(loc,0,pg.pixels.length-1);
      rtotal += (red(pg.pixels[loc]) * matrix[i][j]);
      gtotal += (green(pg.pixels[loc]) * matrix[i][j]);
      btotal += (blue(pg.pixels[loc]) * matrix[i][j]);
    }
  }
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  return color(rtotal, gtotal, btotal);
}
