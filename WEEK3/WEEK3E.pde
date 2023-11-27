//# MOVING MULTIPLE LINES AT DIFFERENT SPEEDS N SIZES
int n = 800;
float dia = 20.0;
float [] xPos = new float[n];
float [] speed = new float[n];
float gap;
float total = 100.0;

void setup()
{
  size(800,800);
  for(int i=0;i<n;i++)
  {
    //xPos[i] = -dia/2;
    xPos[i] = random(width);
    speed[i] = random(0.5,10.0);
  }
  noStroke();
  println(speed);
  //println(xPos);
}

void draw()
{
  gap = height/int(total);
  background(5,12,2);
  for(int i=0;i<total;i++)
  {
    //ellipse(width/2,gap*i+gap/2, dia, dia);
    //ellipse(-dia/2,gap*i+gap/2, dia, dia);
    rect(xPos[i],gap*i+gap/2, speed[i]*50, speed[i]*0.2);
    xPos[i] = xPos[i] + speed[i];
    
    if(xPos[i] > width+(dia/2))
    {
       //xPos[i] = 0; 
       xPos[i] = -250;
    }
  }
}
