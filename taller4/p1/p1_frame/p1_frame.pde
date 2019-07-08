
import processing.video.*;
Movie movie,m1;
PImage label;
PGraphics pg;
float f1,f2,f3,f4,f5,f6,f7,f8,f9;
PShader convolutionShader;

void setup() {
  size(400, 400, P2D);
  m1 = new Movie(this, "xmas.mp4");
  m1.loop();
  movie = m1;
  f1 = f2  = f3 = f4 = f5 = f6 = f7 = f8 = f9 = 0.1111;
  convolutionShader = loadShader("convolutionfrag.glsl");
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  background(100);
  image(movie,0,0,400,400);
  setMask();  
  shader(convolutionShader);
  println(frameRate);
}

void setMask(){  
  convolutionShader.set("f1",f1);
  convolutionShader.set("f2",f2);
  convolutionShader.set("f3",f3);
  convolutionShader.set("f4",f4);
  convolutionShader.set("f5",f5);
  convolutionShader.set("f6",f6);
  convolutionShader.set("f7",f7);
  convolutionShader.set("f8",f8);
  convolutionShader.set("f9",f9);
}
void keyPressed(){
  if(key == '1'){
    f1 = f2  = f3 = f4 = f5 = f6 = f7 = f8 = f9 = 0.1111;         //blur
  }if(key == '2'){
    f1 = f3 = f7 = f9 = f2 = f4 = f6 = f8 = -1;                   //edge detection
    f5 = 8;
  }if(key == '3'){
    f1 = f3 = f7 = f9 = 0;                                        //sharpen
    f2 = f4 = f6 = f8 = -1;
    f5 = 5;
  }if(key == '4'){
    f1 = f3 = f7 = f9 = 0.0625;                                   //gaussian blur
    f2 = f4 = f6 = f8 = 0.125;
    f5 = 0.25;
  }if(key == '5'){
    f1 = -2;                                                      //sobel
    f3 = f7 = 0;
    f2 = f4 = 1;
    f5 = f6 = f8 = 1;
    f9 = 2;
  }
}
