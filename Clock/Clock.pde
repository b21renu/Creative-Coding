int cx, cy;
float secondsRadius, minutesRadius, hoursRadius;
color startColor, middleColor, endColor;
int decagonSize = 10;

void setup() 
{
  size(600, 600);
  stroke(255);
  
  int radius = min(width, height) / 2;
  secondsRadius = radius * 0.72;
  minutesRadius = radius * 0.60;
  hoursRadius = radius * 0.50;
  
  cx = width / 2;
  cy = height / 2;
  
  startColor = color(255, 182, 193);  // Light Pink
  middleColor = color(255, 0, 0);    // Dark Pink
  endColor = color(255, 182, 193);    // Light Pink
}

void draw() 
{
  background(0);
  
  float frameRadius = min(width, height) / 2 - 50; // Adjust the size of the frame
  
  stroke(255); // White color for the frame
  noFill(); // No fill inside the frame
  float frameAngle = TWO_PI / decagonSize;
  beginShape();
  for (int i = 0; i < decagonSize; i++) {
    float angle = i * frameAngle - HALF_PI;
    float x = cx + cos(angle) * frameRadius;
    float y = cy + sin(angle) * frameRadius;
    vertex(x, y);
  }
  endShape(CLOSE);
  
  float s = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
  float m = map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI; 
  float h = map(hour() + norm(minute(), 0, 60), 0, 24, 0, TWO_PI * 2);
  
  float secondColorFactor = map(second(), 0, 59, 0, 1);
  color secondColor = lerpColor(startColor, middleColor, secondColorFactor);
  
  float minuteColorFactor = map(minute(), 0, 59, 0, 1);
  color minuteColor = lerpColor(startColor, middleColor, minuteColorFactor);
  
  float hourColorFactor = map(hour(), 0, 23, 0, 1);
  color hourColor = lerpColor(startColor, middleColor, hourColorFactor);
  
  stroke(secondColor);
  strokeWeight(5);
  line(cx, cy, cx + cos(s) * secondsRadius, cy + sin(s) * secondsRadius);
  
  stroke(minuteColor);
  strokeWeight(10);
  line(cx, cy, cx + cos(m) * minutesRadius, cy + sin(m) * minutesRadius);
  
  stroke(hourColor);
  strokeWeight(15);
  line(cx, cy, cx + cos(h) * hoursRadius, cy + sin(h) * hoursRadius);
}
