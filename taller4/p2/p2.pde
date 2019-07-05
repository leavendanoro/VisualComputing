import nub.primitives.*;
import nub.core.*;
import nub.processing.*;
Scene scene;
PShader shader;
PShape sphere;
color c1, c2, c3;
Node l1, l2, l3;
void setup() {
  colorMode(RGB,1);
  c1 = color(255,255,255);
  size(500,500,P3D);
  sphere = createShape(SPHERE, 50);
  sphere.setFill(c1);
  sphere.setStroke(c1);
  scene = new Scene(this);
  scene.setRadius(500);
  scene.fit();
  l1 = new Node(scene,sphere);
  l1.setPickingThreshold(0);
  l1.randomize();
}
void draw(){
  background(0);
  Vector l1Position = scene.eye().location(l1.position());
  //scene.setUniform(shader,"l1pos",l1Position);
  scene.render();
  //shader.set("c1l1",c1);
}
void mouseClicked(){
  scene.cast();
}
void mouseDragged(){
  if(scene.trackedNode() == null){
    scene.spin(scene.eye());
  }else{
    scene.translate(l1);
  } 
}
