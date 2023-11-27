int aX, aY;
int speed = 5;

void setup() 
{
  size(400, 400);
  aX = width / 15;
  aY = height / 15;
  //ellipse(width/15, height/15, 50, 50);
  move();
}

void draw() 
{
  move();
  background(25);
  fill(255, 0, 0);
  ellipse(aX, aY, 50, 50);
}

void move() 
{
  aX += speed;
  if (aX > width) 
  {
    aX = 0;
  }
}
