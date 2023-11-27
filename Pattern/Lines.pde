int cols = 10;
int rows = 10;
float spacing;
float shapeSize;
color[][] shapeColors;
float colorIncrement = 0.1;
float animationDuration = 10.0;
boolean alternateColor = false;

void setup() 
{
  size(400, 400);
  spacing = width / cols;
  shapeSize = spacing * 0.8;
  shapeColors = new color[cols][rows];
  noFill();
  frameRate(10);

  for (int i = 0; i < rows; i++) 
  {
    for (int j = 0; j < cols; j++) 
    {
      shapeColors[j][i] = color(254, 2, 255); // Pastel blue
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

      float blinkingInterval = map(noise(j, i, elapsedTime), 0, 1, 0, animationDuration);

      float b = blue(shapeColors[j][i]) + colorIncrement;
      shapeColors[j][i] = color(204, 229, constrain(b, 204, 255)); // Pastel blue with increasing brightness

      if (int(elapsedTime / blinkingInterval) % 2 == 0) 
      {
        noFill();
        stroke(alternateColor ? color(255, 0, 229) : color(204, 255, 0)); // Pastel pink and green
        line(x - shapeSize / 2, y, x + shapeSize / 2, y);
      } 
      
      else 
      {
        fill(alternateColor ? color(255, 150, 229) : color(204, 255, 204)); // Pastel pink and green
        ellipse(x, y, shapeSize, shapeSize);
      }
    }
  }
  alternateColor = !alternateColor;
}
