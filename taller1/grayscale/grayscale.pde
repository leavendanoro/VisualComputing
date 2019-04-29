HScrollbar hs1,hs2;
PGraphics pg, pg2, pghist;
PImage img2,img1,img;
int halfImage = 200*200/2;
color black = color(0);
color temp;
float red,blue,green;
int grey;
color bnw;
int[] histogram = new int[256];
int[]range = new int[2];
void setup() {
  size(550, 550);
  pg = createGraphics(200, 200);
  pg2 = createGraphics(200, 200);
  pghist = createGraphics(450,200);
  img1 = loadImage("baboon.png");
  img2 = loadImage("lena.png");
  hs1 = new HScrollbar(50,515,450,10,1);
  hs2 = new HScrollbar(50,535,450,10,1);
  // xpos ypos ancho alto loose
}
  
void draw() {
  int val1 = int(map(hs1.getPos(),hs1.sposMin,hs1.sposMax,0,249));
  int val2 = int(map(hs2.getPos(),hs2.sposMin,hs2.sposMax,0,249));
  if(val1 == val2){
    int[] temp ={0, 255};
    range = temp;
  }else{
    int[] temp = {val1,val2};
    range = sort(temp);
  }
  img = img2;
  //imagen original
  pg.beginDraw();
  pg.background(100);
  pg.image(img,0,0,200,200);
  pg.endDraw();
  image(pg, 50, 50); 
  pg2.beginDraw();
  pg2.background(100);
  for(int i =0; i < histogram.length;i++){
    histogram[i] = 0;
  }
  for(int i = 0; i<=200; i++){
    for(int j= 0; j<=200; j++){
     temp = pg.get(i,j);
     red = red(temp);
     green = green(temp);
     blue = blue(temp);
     grey = (int)(red * 0.2126 + green * 0.7152 + blue * 0.0722);
     histogram[grey]++;
     bnw = color(grey);
     if(range[0]<=grey && grey<=range[1]){
       pg2.set(i,j,bnw);
     }
     
   }
  }
  pg2.endDraw();
  image(pg2,300,50);
  int histMax = max(histogram);
  pghist.beginDraw();
  strokeWeight(1);
  for(int i = 0; i < pghist.width;i++){

    int which = int(map(i,0, pghist.width,0,255));
    int y = int(map(histogram[which],0,histMax,pghist.height,0));
    if(range[0]<=which && which <=range[1]){
      stroke(0);
    }else{
      stroke(255);
    }
    line(i+50,pghist.height+300,i+50,y+300);
    //rect(i,y+300-pghist.height,2,y);
  }
  pghist.endDraw();
  
  image(pghist,50,300);
  hs1.update();
  hs2.update();
  hs1.display();
  hs2.display();
}
class HScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;

  HScrollbar (float xp, float yp, int sw, int sh, int l) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
  }

  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke();
    fill(204);
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio;
  }
}
