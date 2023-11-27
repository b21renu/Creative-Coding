color lightBlueStart = color(173, 216, 230);  // Light blue for hour hand (start color)
color lightBlueEnd = color(135, 206, 235);    // Light blue for hour hand (end color)
color purpleStart = color(128, 0, 128);       // Purple for minute hand (start color)
color purpleEnd = color(186, 85, 211);        // Purple for minute hand (end color)
color pinkStart = color(255, 105, 180);       // Pink for second hand (start color)
color pinkEnd = color(255, 182, 193);         // Pink for second hand (end color)

float minuteAngle = -HALF_PI;    // Starting angle for the minute hand (from positive y-axis)
float hourAngle = -HALF_PI;      // Starting angle for the hour hand (from positive y-axis)
float secondAngle = -HALF_PI;    // Starting angle for the second hand (from positive y-axis)
float minuteStrokeWidth = 25;     // Stroke width for the minute hand
float hourStrokeWidth = 30;       // Stroke width for the hour hand
float secondStrokeWidth = 20;     // Stroke width for the second hand
float minuteCircleRadius = 155;   // Radius for the minute circle
float hourCircleRadius = 125;     // Radius for the hour circle
float secondCircleRadius = 180;   // Radius for the second circle

void setup() {
  size(600, 600);
}

void draw() {
  background(0);
  translate(width / 2, height / 2);  // Center the clock in the canvas

  // Get the current time
  int currentSecond = second();
  int currentMinute = minute();
  int currentHour = hour();

  // Calculate angles based on the current time
  secondAngle = map(currentSecond, 0, 60, -HALF_PI, TWO_PI - HALF_PI);  // Calculate second angle
  minuteAngle = map(currentMinute + norm(currentSecond, 0, 60), 0, 60, -HALF_PI, TWO_PI - HALF_PI);  // Calculate minute angle
  
  // Calculate the hour angle, ensuring it resets after a full circle
  float rawHourAngle = map(currentHour + norm(currentMinute, 0, 60), 0, 12, -HALF_PI, TWO_PI - HALF_PI);
  hourAngle = rawHourAngle % TWO_PI;

  // Interpolate colors for the clock hands
  color currentLightBlue = lerpColor(lightBlueStart, lightBlueEnd, norm(hourAngle, 0, TWO_PI));
  color currentPurple = lerpColor(purpleStart, purpleEnd, norm(minuteAngle, 0, TWO_PI));
  color currentPink = lerpColor(pinkStart, pinkEnd, norm(secondAngle, 0, TWO_PI));

  // Draw the second arc with a gradient stroke and a specific stroke width
  stroke(currentPink);  // Set stroke color to pink
  noFill();             // Don't fill the arc
  strokeWeight(secondStrokeWidth);  // Set the stroke width
  arc(0, 0, secondCircleRadius * 2, secondCircleRadius * 2, -HALF_PI, secondAngle);

  // Draw the minute arc with a gradient stroke and a specific stroke width
  stroke(currentPurple);  // Set stroke color to purple
  strokeWeight(minuteStrokeWidth);  // Set the stroke width
  arc(0, 0, minuteCircleRadius * 2, minuteCircleRadius * 2, -HALF_PI, minuteAngle);

  // Draw the hour arc with a gradient stroke and a different stroke width
  stroke(currentLightBlue);  // Set stroke color to light blue
  strokeWeight(hourStrokeWidth);  // Set the stroke width
  arc(0, 0, hourCircleRadius * 2, hourCircleRadius * 2, -HALF_PI, hourAngle);
}
