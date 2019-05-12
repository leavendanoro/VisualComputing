float x,zoom;
boolean count;
float[] values;
float inc = .05;
short sz  = 30;
void setup(){
  size (550, 550);
  x = width;
  count = true;
  values = new float[2];
  smooth();
  zoom = 10;
}
void draw() {
  translate(width/2,height/2);
  background (0);
  noStroke();
  scale(zoom);

  for(int i = 1000;i>0;i--){
    if(i%2 == 0){
      pushMatrix();
      fill(255);
      circle(0,0,i);
      popMatrix();
    }else{
      pushMatrix();
      fill(0);
      circle(0,0,i);
      popMatrix();
    }
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
