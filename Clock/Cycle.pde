float paddleSize = 20;    // Adjust the size of the paddles
float handleX = width / 0.8; // Constant X position for the handle
float handleY = height / 0.9; // Center the handle line vertically
float handleLineLength = 50; // Adjust the length of the handle line

int seconds = second();  // Get the current seconds
int minutes = minute();  // Get the current minutes
int hours = hour() % 12 + 1; // Get the current hours in a 12-hour format (1 to 12)

int cx, cy;
float secondsRadius;
float minutesRadius;
float hoursRadius;
float clockDiameter;

void setup() 
{
  size(600, 600);
  background(255);
  stroke(0);
  
  int radius = min(width, height) / 2;
  secondsRadius = radius * 0.72;
  minutesRadius = radius * 0.60;
  hoursRadius = radius * 0.50;
  clockDiameter = radius * 1.8;
  
  cx = width / 2;
  cy = height / 2;
}

void draw() 
{
  // Update the current time
  seconds = second();
  minutes = minute();
  hours = (hour() % 12) + 1; // Get the current hours in a 12-hour format (1 to 12)
  
  // Calculate the y-coordinate for the horizontal line between the wheels
  float lineY = height / 2;
  
  // Draw the handle and the line connecting it to the first wheel's center
  stroke(0);
  line(handleX, handleY, width / 3, lineY); // Make the handle horizontal
  fill(150);
  ellipse(handleX, handleY, 30, 30);
  rect(handleX - handleLineLength / 10, handleY - 5, handleLineLength, 10);

  // Wheel 1 (Clock with a minute, hour, and second hand)
  pushMatrix();
  translate(1 * width / 3, lineY); // Adjust the position to align with the horizontal line
  DrawClock(135, minutes, hours, seconds);
  popMatrix();

  // Wheel 2
  pushMatrix();
  translate(1.8 * width / 3, lineY); // Adjust the position to align with the horizontal line
  drawWheel();
  popMatrix();
  
  // Draw a line between the centers of the two wheels
  stroke(5);
  line(1 * width / 3, lineY, 1.8 * width / 3, lineY);
}

void drawWheel() 
{
  int size = 100;
  strokeWeight(4);
  ellipse(0, 0, size, size); // Outer rim
  for (int i = 0; i < 60; i++) 
  {
    float x = cos(TWO_PI / 12 * i) * (size / 2);
    float y = sin(TWO_PI / 12 * i) * (size / 2);
    line(x, y, x * 1.2, y * 1.2); // Spokes
  }
}

void DrawClock(float size, int minuteHand, int hourHand, int secondHand) 
{
  fill(100);
  stroke(0);
  strokeWeight(4);
  ellipse(0, 0, size, size); // Outer rim
  for (int i = 0; i < 60; i++) 
  {
    float x = cos(TWO_PI / 12 * i) * (size / 2);
    float y = sin(TWO_PI / 12 * i) * (size / 2);
    // Draw the hour hand
    if (i == hourHand) {
      stroke(0, 0, 255); // Blue color for hour hand
      line(0, 0, x * 0.6, y * 0.6);
      stroke(0);
    }
    // Draw the minute hand
    if (i == minuteHand) {
      stroke(255, 0, 0); // Red color for minute hand
      line(0, 0, x * 0.8, y * 0.8);
      stroke(0);
    }
    // Draw the second hand
    if (i == secondHand) {
      stroke(0, 255, 0); // Green color for second hand
      line(0, 0, x * 0.5, y * 0.5);
      stroke(0);
    }
    line(x, y, x * 1.2, y * 1.2); // Spokes
  }
}
