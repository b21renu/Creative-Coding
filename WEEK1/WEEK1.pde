//1. https://p5js.org/examples/
//2. https://py.processing.org/
//3. https://processing.org/
//4. https://openprocessing.org/discover/
//5. https://processingfoundation.org/
//6. https://game-designer.club/content.html#carousel_d823
//7. https://openframeworks.cc/
//8. https://www.creativeapplications.net/

void setup() {
  size(400, 400);
   //background(255,0,0);
}

void draw() {
  //background(220);
  background(255,0,0);
  //100-width, 100-heigth
  // follow order of cmds
  // ellipse(width/2,height/2, 100,100);
  ellipse(width/2,height/2, sin(millis()*0.0001*mouseX)*100,100);
}
