int strokeW = 3;
int circle1x, circle2x, circle3x, circle1y, circle23y, rad, auxPos, translation, jump;
void setup() {
  size(700, 402);
  circle1x = width/2;
  circle1y = height/3 - 20;
  circle2x = width/4;
  circle23y = 2*height/3 + 20;
  circle3x = 3*width/4;
  rad = 150;
  translation = 1;
  strokeCap(SQUARE);
}

void draw() {
  background(255);
  strokeWeight(strokeW);
  jump = strokeW * 3;
  for (int i = 0; i < height; i += jump) {
    stroke(255, 0, 0);
    line(0, i, width, i);
    stroke(0, 255, 0);
    line(0, i + strokeW, width, i + strokeW);
    stroke(0, 0, 255);
    line(0, i + strokeW*2, width, i + strokeW*2);
  }
  noStroke();
  circle(circle1x, circle1y, rad);
  circle(circle2x, circle23y, rad);
  circle(circle3x, circle23y, rad);
  
  for (int i = 0; i < height; i += jump) {
    if (i < height/2) {
      RB(translation, i);
    } else {
      GB(translation, i);
      RG(translation, i);
    }
  }
}

void RB(int x, int y) {
  int auxX = circle1x + rad/2 + 5;
  stroke(255, 0, 0);
  line(auxX - x, y, auxX, y);
  stroke(0, 0, 255);
  line(auxX - x, y + strokeW*2, auxX, y + strokeW*2);
}

void GB(int x, int y) {
  int auxX = circle2x + rad/2 + 5;
  stroke(0, 255, 0);
  line(auxX - x, y + strokeW, auxX, y + strokeW);
  stroke(0, 0, 255);
  line(auxX - x, y + strokeW*2, auxX, y + strokeW*2);
}

void RG(int x, int y) {
  int auxX = circle3x + rad/2 + 5;
  stroke(255, 0, 0);
  line(auxX - x, y, auxX, y);
  stroke(0, 255, 0);
  line(auxX - x, y + strokeW, auxX, y + strokeW);
}

void keyPressed() {
  switch(keyCode) {
    case 37:
      if (translation + 2 < rad + 10) {
        translation += 2;
      } else {
        translation = rad + 10;
      }
      println("Translation: " + translation);
      break;
      
    case 38:
      strokeW += 2;
      println("line weight: " + strokeW);
      break;
      
    case 39:
      if (translation - 2 >= 0) {
        translation -= 2;
      } else {
        translation = 0;
      }
      println("Translation: " + translation);
      break;
      
    case 40:
      if (strokeW - 2 >= 1) strokeW -= 2;
      println("line weight: " + strokeW);
      break;
      
    default:
      break;
  }
}
