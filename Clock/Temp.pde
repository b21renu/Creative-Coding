float wc1 = 170;
float wc2 = 430;

void setup(){
size(600, 600);
noFill();
}

void draw(){
  float min = map(minute(), 0, 60, 0, TWO_PI)-PI/2;
  float hour = hour() % 12; 
  hour  = map(hour(), 0, 12, 0, TWO_PI)-PI/2;
  background(255);
  strokeWeight(10);
  push();
  translate(wc1, height/2);
  rotate(min);
  line(0,0, 60, 0);
  pop();
  ellipse(wc1, width/2, 200, 200);
  
  strokeWeight(10);
  push();
  translate(wc2, height/2);
  rotate(hour);
  line(0,0, 60, 0);
  pop();
  ellipse(wc2, width/2, 150, 150);  
}
