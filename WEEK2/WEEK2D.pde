float radius = random(255);

void setup()
{
  size(400,400);
  background(255,0,0);
  stroke(0,255,0);
  fill(0,0,255);
  fill(0,0,random(255));
  fill(random(255),random(255),random(255));
  for(int I=0;I<10;I++)
  {
    radius = random(255);
    for(int J=0;J<10;J++)
    {
      radius = random(255);
      fill(random(255),random(255),random(255));
      ellipse(I*40+20,J*40+20,radius, radius);
    }
  }
}
