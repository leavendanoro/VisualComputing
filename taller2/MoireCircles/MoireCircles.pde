float x,zoom;
boolean count;
float[] values;
float inc = .05;
void setup(){
  size (550, 550);
  x = width;
  count = true;
  values = new float[2];
  smooth();
  zoom = 50;
}
void draw() {
  translate(width/2,height/2);
  background (0);
  strokeWeight(1);
  zoom = constrain(zoom,0,100);
  scale(zoom);
  fill(255);
  for(int i = 5000;i>0;i-=4){
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
