//# MOVING A BALL
float xPos = -50.0;
float speed = 2.0;

void setup()
{
  size(400,400);
  background(50,0,0);
}

void draw()
{
  background(50,0,0);
  ellipse(xPos, height/2,100,100);
  xPos = xPos + speed;
  int sm = sum(5,6);
  println(sm);
  //println(xPos);
  if(xPos > 450)
  {
    xPos = -50.0;
  }
}

int sum(int x, int y)
{
  return x+y;
}
