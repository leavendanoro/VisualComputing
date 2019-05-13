float ringWidth = 22, i = 0, speed;
PShape ring1, ring21, ring22, ring31, ring32;
int blue, red, white, opacity;
void setup() {
  size(600, 600);
  noStroke();
  speed = 0.005;
  opacity = 255;
  blue = color(0,5,120, opacity);
  red = color(230, 0, 0);
  white = color(255,255,255);
  ring1 = starGen(500, blue);
  ring21 = starGen(430, white);
  ring22 = starGen(430, red);
  ring31 = starGen(360, blue);
  ring32 = starGen(360, white);
}

void draw() {
  background(255);
  translate(width/2, height/2);
  if (i > TWO_PI) {
    i = 0;
  }
  
  shape(ring1);
  shape(ring21);
  shape(ring22);
  shape(ring32);
  shape(ring31);
  
  ring22.rotate(speed);
  ring32.rotate(speed);
  
}

void drawStars() {
  blue = color(0,5,120, opacity);
  ring1.setFill(blue);
  ring31.setFill(blue);
}

PShape starGen(float size, int c) {
  PShape star = createShape();
  float angle = radians(30), x, y;
  float angle2 = radians(15);
  float r1 = size/2, r2 = r1 - ringWidth;
  star.beginShape();
  for(int i = 0; i < 12; i++) {
    x = cos(angle*i)*r1;
    y = sin(angle*i)*r1;
    star.vertex(x, y);
    x = cos(angle*i + angle2)*r2;
    y = sin(angle*i + angle2)*r2;
    star.vertex(x, y);
  }
  star.vertex(r1, 0);
  star.endShape();
  star.setFill(c);
  return star;
}

void keyPressed() {
  switch(keyCode) {
    case 37:
      if (speed > 0) speed -= 0.005;
      println("Speed: " + speed);
      break;
      
    case 38:
      if (opacity < 255) opacity += 10;
      drawStars();
      println("Opacity: " + opacity);
      break;
      
    case 39:
      if (speed < TWO_PI) speed += 0.005;
      println("Speed: " + speed);
      break;
      
    case 40:
      if (opacity > 0) opacity -= 10;
      drawStars();
      println("Opacity: " + opacity);
      break;
      
    default:
      break;
  }
}
