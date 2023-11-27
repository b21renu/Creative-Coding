float radius = random(255);

void setup()
{
  size(400,400);
  background(0);
  stroke(0,255,0);
  fill(0,0,255);
  fill(0,0,random(255));
  fill(random(255),random(255),random(255));
  for(int i=0;i<10;i++)
  {
    for(int j=0;j<10;j++)
    {
      fill(random(255),random(255),random(255));
      ellipse(i*40+20,j*40+20,radius,radius);
    }
  }
}
