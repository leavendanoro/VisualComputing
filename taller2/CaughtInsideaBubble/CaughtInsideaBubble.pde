bulleye b1,b2,b3,b4;
bubbles bb1;
int s1,s2,s3,s4;
color c1,c2,c3,c4;
void setup(){
  size(600,600);
  c1 = color(237, 186, 177); // color circunferencia grande
  c2 = color(201, 168, 237);
  c3 = color(93, 194, 216);
  c4 = color(189, 234, 117);// color circunferencia pequeña
  s1 = 200;
  s2 = 150;
  s3 = 100;
  s4 = 50;
  b1 = new bulleye(s1,s2,s3,s4,width/4,height/4,c1,c2,c3,c4);
  b2 = new bulleye(s1,s2,s3,s4,3*width/4,height/4,c1,c2,c3,c4);
  b3 = new bulleye(s1,s2,s3,s4,width/4,3*height/4,c1,c2,c3,c4);
  b4 = new bulleye(s1,s2,s3,s4,3*width/4,3*height/4,c1,c2,c3,c4);
  bb1 = new bubbles(s1,s2,s3,s4,width,height);
}
void draw(){
  if(key == 's'){
  }else{
    background(211);
    pushMatrix();
    stroke(0);
    line(width/2+5,height/2,width/2-5,height/2);
    line(width/2,height/2+5,width/2,height/2-5);
    popMatrix();
    if(frameCount % 100 <= 50){
    b1.display();
    b2.display();
    b3.display();
    b4.display();
    }else{
      if(key == '1'){
      bb1 = new bubbles(s1,s2,s3,s4,width,height);
      }else if(key == '2'){
      bb1 = new bubbles(s2,s3,s1,s4,width,height);
      }else if(key == '3'){
      bb1 = new bubbles(s3,s4,s1,s2,width,height);
      }else if(key == '4'){
      bb1 = new bubbles(s4,s1,s3,s2,width,height);
      }else if (key == '5'){
      bb1 = new bubbles(s3,s1,s2,s3,width,height);
      }else if (key == '6'){
      bb1 = new bubbles(s3,s2,s4,s1,width,height);
      }
      bb1.display();
    }
  }

}

class bubbles{
  int s1,s2,s3,s4,x,y;
  bubbles(int s1_, int s2_,int s3_,int s4_,int x_,int y_){
    s1 = s1_;
    s2 = s2_;
    s3 = s3_;
    s4 = s4_;
    x = x_;
    y = y_;
  }
  void display(){
    pushMatrix();
    stroke(0);
    noFill();
    circle(x/4,y/4,s1);
    circle(3*x/4,y/4,s2);
    circle(x/4,3*y/4,s3);
    circle(3*x/4,3*y/4,s4);
    popMatrix();
  }
}


class bulleye{
  int s1,s2,s3,s4,x,y;
  color c1,c2,c3,c4;
  bulleye(int s1_, int s2_,int s3_,int s4_,int x_,int y_, color c1_,color c2_,color c3_,color c4_){
    s1 = s1_;
    s2 = s2_;
    s3 = s3_;
    s4 = s4_;
    x = x_;
    y = y_;
    c1 = c1_;
    c2 = c2_;
    c3 = c3_;
    c4 = c4_;
  }
  void display(){
    pushMatrix();
    translate(x,y);
    noStroke();
    fill(c1);
    circle(0,0,s1);
    popMatrix();
    pushMatrix();
    translate(x,y);
    noStroke();
    fill(c2);
    circle(0,0,s2);
    popMatrix();
    pushMatrix();
    translate(x,y);
    noStroke();
    fill(c3);
    circle(0,0,s3);
    popMatrix();
    pushMatrix();
    translate(x,y);
    noStroke();
    fill(c4);
    circle(0,0,s4);
    popMatrix();
  }
}
void keyPressed () {
  if (key == 'a') {
 
  }
}
