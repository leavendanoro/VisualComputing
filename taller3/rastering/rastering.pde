import nub.timing.*;
import nub.primitives.*;
import nub.core.*;
import nub.processing.*;

// 1. Nub objects
Scene scene;
Node node;
Vector v1, v2, v3;
// timing
TimingTask spinningTask;
boolean yDirection;
// scaling is a power of 2
int n = 4;

// 2. Hints
boolean triangleHint = true;
boolean gridHint = true;
boolean debug = true;

// 3. Use FX2D, JAVA2D, P2D or P3D
String renderer = P3D;

// 4. Window dimension
int dim = 9;

float dir, x1, y1, x2, y2, x3, y3, highX, highY, lowX, lowY;

void settings() {
  size(int(pow(2, dim)), int(pow(2, dim)), renderer);
}

void setup() {
  scene = new Scene(this);
  if (scene.is3D())
    scene.setType(Scene.Type.ORTHOGRAPHIC);
  scene.setRadius(width/2);
  scene.fit(1);

  // not really needed here but create a spinning task
  // just to illustrate some nub.timing features. For
  // example, to see how 3D spinning from the horizon
  // (no bias from above nor from below) induces movement
  // on the node instance (the one used to represent
  // onscreen pixels): upwards or backwards (or to the left
  // vs to the right)?
  // Press ' ' to play it
  // Press 'y' to change the spinning axes defined in the
  // world system.
  spinningTask = new TimingTask() {
    @Override
    public void execute() {
      scene.eye().orbit(scene.is2D() ? new Vector(0, 0, 1) :
        yDirection ? new Vector(0, 1, 0) : new Vector(1, 0, 0), PI / 100);
    }
  };
  scene.registerTask(spinningTask);

  node = new Node();
  node.setScaling(width/pow(2, n));

  // init the triangle that's gonna be rasterized
  randomizeTriangle();
}

void draw() {
  background(0);
  stroke(0, 255, 0);
  if (gridHint)
    scene.drawGrid(scene.radius(), (int)pow(2, n));
  if (triangleHint)
    drawTriangleHint();
  pushMatrix();
  pushStyle();
  scene.applyTransformation(node);
  triangleRaster();
  popStyle();
  popMatrix();
}

// Implement this function to rasterize the triangle.
// Coordinates are given in the node system which has a dimension of 2^n
void triangleRaster() {
  // node.location converts points from world to node
  // here we convert v1 to illustrate the idea
  
  coloringTriangle();
  if (debug) {
    pushStyle();
    stroke(255, 255, 0, 125);
    //point(round(node.location(v1).x()), round(node.location(v1).y()));
    popStyle();
  }
}

void randomizeTriangle() {
  int low = -width/2;
  int high = width/2;
  v1 = new Vector(random(low, high), random(low, high));
  v2 = new Vector(random(low, high), random(low, high));
  v3 = new Vector(random(low, high), random(low, high));
  updateVars();
}

void drawTriangleHint() {
  pushStyle();
  noFill();
  strokeWeight(2);
  stroke(255, 0, 0);
  triangle(v1.x(), v1.y(), v2.x(), v2.y(), v3.x(), v3.y());
  strokeWeight(5);
  stroke(0, 255, 255);
  point(v1.x(), v1.y());
  point(v2.x(), v2.y());
  point(v3.x(), v3.y());
  popStyle();
}

void updateVars() {
  x1 =  node.location(v1).x();
  y1 =  node.location(v1).y();
  x2 =  node.location(v2).x();
  y2 =  node.location(v2).y();
  x3 =  node.location(v3).x();
  y3 =  node.location(v3).y();
  highX = max(x1, x2, x3);
  highY = max(y1, y2, y3);
  lowX = min(x1, x2, x3);
  lowY = min(y1, y2, y3);
  dir = inArea(x1, y1, x2, y2, x3, y3);
}

void coloringTriangle() {
  float a1, a2, a3;
  pushStyle();
  noStroke();
  for(float i = round(lowX-1)+0.5; i <= highX+1; i++) {
    for(float j = round(lowY-1)+0.5; j <= highY+1; j++) {
      a1 = inArea(x1, y1, x2, y2, i, j);
      a2 = inArea(x2, y2, x3, y3, i, j);
      a3 = inArea(x3, y3, x1, y1, i, j);
      if ((dir >= 0 && a1 >= 0 && a2 >= 0 && a3 >= 0) || (dir < 0 && a1 < 0 && a2 < 0 && a3 < 0)){
        a1 /= dir;
        a2 /= dir;
        a3 /= dir;
        pushStyle();
        fill(255 * a1, 255 * a2, 255 * a3);
        rect(i-0.5,j-0.5,1,1);
      }
    }
  }
  popStyle();
}


float inArea(float x1,float y1,float x2,float y2,float x3,float y3) {
  return (x1-x3)*(y2-y3)-(y1-y3)*(x2-x3);
}

void keyPressed() {
  if (key == 'g')
    gridHint = !gridHint;
  if (key == 't')
    triangleHint = !triangleHint;
  if (key == 'd')
    debug = !debug;
  if (key == '+') {
    n = n < 7 ? n+1 : 2;
    node.setScaling(width/pow( 2, n));
    updateVars();
  }
  if (key == '-') {
    n = n >2 ? n-1 : 7;
    node.setScaling(width/pow( 2, n));
    updateVars();
  }
  if (key == 'r')
    randomizeTriangle();
  if (key == ' ')
    if (spinningTask.isActive())
      spinningTask.stop();
    else
      spinningTask.run(20);
  if (key == 'y')
    yDirection = !yDirection;
}
