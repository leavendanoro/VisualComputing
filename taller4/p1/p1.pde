
// Texture from Jason Liebig's FLICKR collection of vintage labels and wrappers:
// http://www.flickr.com/photos/jasonliebigstuff/3739263136/in/photostream/
/*float[][] matrix = { { -1, -1, -1 },
                     { -1,  8, -1 },
                     { -1, -1, -1 } };
/* float[][] matrix = { { 0, -1, 0 },
                     { -1,  5, -1 },
                     { 0, -1, 0 } };
float[][] matrix = { { 0.1111, 0.1111, 0.1111 },
                     { 0.1111,  0.1111, 0.1111 },
                     { 0.1111, 0.1111,0.1111 } };
 float[][] matrix = { { 0.0625, 0.125, 0.0625 },
                     { 0.125,  0.25, 0.125 },
                     { 0.0625, 0.125,0.0625 } };*/

PImage label;
PShape can;
float angle;
float f1,f2,f3,f4,f5,f6,f7,f8,f9;
PShader convolutionShader;

void setup() {
  size(640, 360, P3D);
  label = loadImage("lachoy.jpg");
  can = createCan(100, 200, 32, label);
  f1 = f2  = f3 = f4 = f5 = f6 = f7 = f8 = f9 = 0.1111;
  convolutionShader = loadShader("convolutionfrag.glsl");
}

void draw() {    
  background(0);
  setMask();
  shader(convolutionShader);
  translate(width/2, height/2);
  rotateY(angle);  
  shape(can);  
  angle += 0.01;
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
PShape createCan(float r, float h, int detail, PImage tex) {
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUAD_STRIP);
  sh.noStroke();
  sh.texture(tex);
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    float u = float(i) / detail;
    sh.normal(x, 0, z);
    sh.vertex(x * r, -h/2, z * r, u, 0);
    sh.vertex(x * r, +h/2, z * r, u, 1);    
  }
  sh.endShape(); 
  return sh;
}
