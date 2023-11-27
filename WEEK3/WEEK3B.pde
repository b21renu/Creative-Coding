//# MOVING 3 BALLS AT DIFF SPEEDS - MY CODE
//int aX, aY, bX, bY, cX, cY;
int aX, bX, cX;
int speed_a = 1, speed_b = 3, speed_c = 5;

void setup() 
{
  size(500, 500);
  aX = width / 20;
  //aY = height / 20;
  
  bX = width / 5;
  //bY = height / 5;
  
  cX = width / 3;
  //cY = height / 3;
  //ellipse(width/15, height/15, 50, 50);
  move();
}

void draw() 
{
  move();
  background(25);
  fill(255, 0, 0);
  ellipse(aX, height/20, 40, 40);
  ellipse(bX, height/5, 40, 40);
  ellipse(cX, height/3, 40, 40);
  //ellipse(aX, aY, 40, 40);
  //ellipse(bX, bY, 40, 40);
  //ellipse(cX, cY, 40, 40);
}

void move() 
{
  aX += speed_a;
  if (aX > width) 
  {
    aX = 0;
  }
  
  bX += speed_b;
  if (bX > width) 
  {
    bX = 0;
  }
  
  cX += speed_c;
  if (cX > width) 
  {
    cX = 0;
  }
}
