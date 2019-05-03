PGraphics pg, pg1, pg2, pg3, pg4;
boolean showBg = true;
void setup(){
  size(1200,300);
  pg1 = createGraphics(300,300);
  pg2 = createGraphics(300,300);
  pg3 = createGraphics(300,300);
  pg4 = createGraphics(300,300);  
  pg = createGraphics(100,100);
}
void draw(){
  background(211);
  pg.beginDraw();
  pg.noStroke();
  pg.fill(180);
  pg.circle(pg.width/2,pg.height/2,50);
  pg.endDraw();
  pg1.beginDraw();
  pg1.background(0);
  pg1.endDraw();
  pg2.beginDraw();
  pg2.background(112);
  pg2.endDraw();
  pg3.beginDraw();
  pg2.background(240);
  pg3.endDraw();
  pg4.beginDraw();
  pg4.background(255);
  pg4.endDraw();
  if(showBg){
    image(pg1,0,0);
    image(pg2,pg1.width,0);
    image(pg3,pg1.width+pg2.width,0);
    image(pg4,pg1.width+pg2.width+pg3.width,0);
  }
  image(pg,100,100);
  image(pg,400,100);
  image(pg,700,100);
  image(pg,1000,100);
}

void mouseClicked(){
  showBg = !showBg;
}
