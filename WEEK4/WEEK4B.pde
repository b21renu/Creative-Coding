//# CODE - 2
//float a = 0;
float rot = 1.0;
void setup()
{
  size(600,600);
  rectMode(CENTER);
}

void draw()
{
  push();
  background(0);
  //translate(width/2,height/2);
  translate(rot,height*0.1);
  scale(1);
  //scale(rot);
  //scale(rot*0.1);
  //rotate(radians(15));
  rotate(rot);
  //rotate(PI/2); 
  fill(0,255,0);
  rect(0,0,200,100);
  pop();
  
  rot += 0.1;
  
  //push();
  //rotate(radians(15));
  
  //rotate(-PI/2);
  //rect(0,0,200,100);
}
