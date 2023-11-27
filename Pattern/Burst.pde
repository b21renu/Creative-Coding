int totalFrames = 50;  // Total frames for the animation
int frameCount = 0;    // Current frame

void setup() 
{
  size(800, 800);
  frameRate(10);
  background(35);  // White background
  noFill();
  strokeWeight(3);
}

void draw() 
{
  if (frameCount < totalFrames) 
  {
    float radius = map(frameCount, 0, totalFrames, 0, width / 2);
    float angleIncrement = TWO_PI / 12;

    translate(width / 2, height / 2);

    // Generate a random color for strokes on each frame
    color blinkColor = color(random(300), random(200), random(100));
    stroke(blinkColor);

    beginShape();
    
    for (float angle = 0; angle < TWO_PI; angle += angleIncrement) 
    {
      float x = cos(angle) * radius;
      float y = sin(angle) * radius;
      vertex(x, y);
    }
    
    endShape(CLOSE);

    translate(-width / 2, -height / 2);

    frameCount++;
  } 
  
  else 
  {
    noLoop();
  }
}
