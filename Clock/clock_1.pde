boolean hexagonVisible = true;
int blinkInterval = 500; // Blink interval in milliseconds
long lastBlinkTime = 0;

int numHexagons = 23; // Number of hexagons in the circle
float circleRadius = 150; // Reduced radius of the circle
float hexRadius = 20; // Increased size of individual hexagons

void setup() {
  size(400, 400);
  background(255); // White background
  frameRate(100); // Set the frame rate
}

void draw() {
  int currentHour = hour(); // Get the current hour
  //println(currentHour);
  int blinkCount = currentHour % numHexagons; // Calculate the number of hexagons to blink

  if (millis() - lastBlinkTime > blinkInterval) {
    background(255); // Clear the canvas
    for (int i = 0; i < numHexagons; i++) {
      float angle = TWO_PI / numHexagons * i;
      float x = width / 2 + cos(angle) * circleRadius;
      float y = height / 2 + sin(angle) * circleRadius;

      if (hexagonVisible && i < blinkCount) {
        fill(35, 0, 0); // Red color
      } 
      else {
        noFill(); // Make the hexagon's border invisible
      }
      drawHexagon(x, y);
    }
    lastBlinkTime = millis();
    hexagonVisible = !hexagonVisible; // Toggle visibility
  }
}

void drawHexagon(float x, float y) {
  beginShape();
  for (int i = 0; i < 6; i++) {
    float angle = TWO_PI / 6 * i;
    float xOffset = hexRadius * cos(angle);
    float yOffset = hexRadius * sin(angle);
    vertex(x + xOffset, y + yOffset);
  }
  endShape(CLOSE);
}
