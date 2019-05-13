float zoom;
float inc = .05;
int circles,spacing;
void setup(){
  size (550, 550);
  smooth();
  zoom = 50;
  circles = 5000;
  spacing = 4;
}
void draw() {
  translate(width/2,height/2);
  background (0);
  zoom = constrain(zoom,0,100);
  scale(zoom);
  fill(255);
  for(int i = circles;i>0;i-=spacing){
      circle(0,0,i);
  }
}
void keyPressed(){
  if(key == CODED){
    if(keyCode == RIGHT){
      zoom += inc;
    }else if(keyCode == LEFT){
      zoom -= inc;
    }
  }
}
