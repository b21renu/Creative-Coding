int cols = 10;
int rows = 10;
float spacing;
float circleSize;
color[][] circleColors;
float colorIncrement = 0.1;
float animationDuration = 10.0;

void setup() 
{
  size(400, 400);
  spacing = width / cols;
  circleSize = spacing * 0.8;
  circleColors = new color[cols][rows];
  noStroke();
  frameRate(30);
  
  for (int i = 0; i < rows; i++) 
  {
    for (int j = 0; j < cols; j++) 
    {
      circleColors[j][i] = color(0, 0, 100);
    }
  }
}

void draw() 
{
  background(0);
  float elapsedTime = millis() / 1000.0;
  
  for (int i = 0; i < rows; i++) 
  {
    for (int j = 0; j < cols; j++) 
    {
      float x = j * spacing + spacing / 2;
      float y = i * spacing + spacing / 2;
      
      float blinkingInterval = map(
        noise(j, i, elapsedTime), 0, 1, 0, animationDuration
      );
      
      float b = blue(circleColors[j][i]) + colorIncrement;
      circleColors[j][i] = color(0, 0, constrain(b, 0, 255));
      
      if (int(elapsedTime / blinkingInterval) % 2 == 0) 
      {
        fill(circleColors[j][i]);
      } 
      else 
      {
        noFill();
      }
      
      ellipse(x, y, circleSize, circleSize);
    }
  }
}
