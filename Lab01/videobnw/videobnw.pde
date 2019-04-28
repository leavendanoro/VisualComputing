import processing.video.*;
PGraphics pg, pg2;
color temp, bnw;
float red,blue,green;
int grey;
Movie movie;
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
  pg.beginDraw();
  pg.background(100);
  pg.image(movie,0,0,200,200);
  pg.endDraw();
  pg2.beginDraw();
  pg2.background(100);
  for(int i = 0; i<=200; i++){
    for(int j= 0; j<=200; j++){
       temp = pg.get(i,j);
       red = red(temp);
       green = green(temp);
       blue = blue(temp);
       grey = (int)(red * 0.2126 + green * 0.7152 + blue * 0.0722);
       bnw = color(grey);
       pg2.set(i,j,bnw);
   }
  }
  pg2.endDraw();
  image(pg, 0, 0);
  image(pg2,210,0);
  println(frameRate);
}
