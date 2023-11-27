//# MOVING MULTIPLE BALLS WITH DIFF SPEEDS
int n = 800;
float dia = 20.0;
float [] xPos = new float[n];
float [] speed = new float[n];
float gap;

void setup()
{
  size(800,800);
  for(int i=0;i<n;i++)
  {
    //xPos[i] = -dia/2;
    xPos[i] = random(width);
    speed[i] = random(1.0,5.0);
  }
  noStroke();
  println(speed);
  //println(xPos);
}

void draw()
{
  gap = height/n;
  background(5,12,2);
  for(int i=0;i<n;i++)
  {
    //ellipse(width/2,gap*i+gap/2, dia, dia);
    //ellipse(-dia/2,gap*i+gap/2, dia, dia);
    ellipse(xPos[i],gap*i+gap/2, speed[i]*5, speed[i]*5);
    xPos[i] = xPos[i] + speed[i];
    
    if(xPos[i] > width+(dia/2))
    {
       //xPos[i] = 0; 
       xPos[i] = -dia/2;
    }
  }
}
