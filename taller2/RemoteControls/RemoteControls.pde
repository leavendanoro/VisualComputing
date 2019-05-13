color c1, c2;
int sqwidth, sqheight, a, x, y;
float b,yp;
void setup(){
  size(700,400);
  c1 = color(27, 56, 38);
  c2 = color(103, 247, 163);
  //tamaño de los rectangulos
  sqwidth =50;
  sqheight = 100;
  //Parametros para el cambio de color
  a = 500;
  b = 500.0;;
}
void draw(){
  noStroke();
  //Limitación de las posiciones en x y los tamaños en y de los rectangulos que se mueven
  x = constrain(x,0,100);
  y = constrain(y,sqheight,2*sqheight);
  yp = constrain(yp,0,50);
  pushMatrix();
  fill(c1);
  rect(0,0,width/2,height);
  popMatrix();
  pushMatrix();
  fill(c2);
  rect(width/2,0,width/2,height);
  rect((width/4)-(3*sqwidth/2)- x,(height/2)-(sqheight/2)-yp,sqwidth,y);
  rect((width/4)+(sqwidth/2)+ x,(height/2)-(sqheight/2)-yp,sqwidth,y);
  popMatrix();
  pushMatrix();
  fill(c1);
  rect((3*width/4)-(3*sqwidth/2)-x,(height/2)-(sqheight/2)-yp,sqwidth,y);
  rect((3*width/4)+(sqwidth/2)+x,(height/2)-(sqheight/2)-yp,sqwidth,y);
  popMatrix();
  pushMatrix();
  fill(lerpColor(c2, c1, (((millis()/a)%2==0)?millis()%a:a-millis()%a)/b));
  rect((width/4)-(sqwidth/2),(height/2)-(sqheight/2),sqwidth,sqheight);
  popMatrix();
  pushMatrix();
  fill(lerpColor(c2, c1, (((millis()/a)%2==0)?millis()%a:a-millis()%a)/b));
  rect((3*width/4)-(sqwidth/2),(height/2)-(sqheight/2),sqwidth,sqheight);
  popMatrix();
}
void keyPressed(){
  if(key == CODED){
    if(keyCode == RIGHT){
      x++;
    }else if(keyCode == LEFT){
      x--;
    }else if(keyCode == UP){
      yp+=0.5;
      y++;
    }else if(keyCode == DOWN){
      y--;
      yp-=0.5;
    }
  }
}
