int Y_AXIS = 1;
int X_AXIS = 2;
color b1, b2, c1, c2;
boolean condition = true;
void setup(){
  b1 = color(255);
  b2 = color(0);
  size(550,550);
}
void draw(){
  background(255);
  if(condition){
    drawSquares(5);
  }  
  drawMesh();
}
void drawMesh(){
  strokeWeight(5);
  stroke(255,0,0);
  for(int i = 0; i<=height; i = i+10){
    line(0,i,width,i);
  }
}
void drawSquares(int ratio){
  float temp = width/ratio;
  noStroke();
  for(int i = 0; i<=width;i +=temp){
    float c = map(i,0,width,0,255);
    fill(c);
    rect(i,0,temp,height);
  }
}
void mouseClicked(){
  condition = !condition;
}
