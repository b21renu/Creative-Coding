//# CODE -  1
float a = 0;
void setup()
{
  size(600,600);
  rectMode(CENTER);
}

void draw()
{
  background(0);
  translate(width/2,height/2);
  // every command below this follows this commad it rotates 90 degrees and 
  //it wont overwrite the value but nxt commands can add to this value
  rotate(-PI/4); 
 //rect(width/2,height/2,200,100);
  rect(0,0,200,100);
  rotate(-PI/2);
  rect(0,0,200,100);
}
