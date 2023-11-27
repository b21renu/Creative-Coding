int cols = 4;
int rows = 4;
float spacing;
float circleRadius = 15.0; // Radius of the circles
color[][] circleColors;
float colorIncrement = 0.1;
float animationDuration = 10.0;

ArrayList<Sprinkle> sprinkles = new ArrayList<Sprinkle>();
int sprinklingStartTime = -1; // -1 indicates no sprinkling

void setup() {
  size(200, 200);
  spacing = width / cols;
  circleColors = new color[cols][rows];
  noStroke(); // No stroke for the circles
  frameRate(30);

  resetToOriginalPattern();
}

void draw() {
  background(0);
  float elapsedTime = millis() / 1000.0;

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      float x = j * spacing + spacing / 2;
      float y = i * spacing + spacing / 2;

      float blinkingInterval = map(
        noise(j, i, elapsedTime), 0, 1, 0, animationDuration
      );

      float b = blue(circleColors[j][i]) + colorIncrement;
      circleColors[j][i] = color(0, 0, constrain(b, 0, 255));

      fill(circleColors[j][i]);
      ellipse(x, y, circleRadius * 2, circleRadius * 2);
    }
  }

  for (int i = sprinkles.size() - 1; i >= 0; i--) {
    Sprinkle s = sprinkles.get(i);
    s.update();
    s.display();
    if (s.isExpired()) {
      sprinkles.remove(i);
    }
  }

  // Check if the sprinkling duration is over
  if (sprinklingStartTime != -1 && millis() - sprinklingStartTime > 5000) {
    sprinkles.clear(); // Remove all sprinkles after 5 seconds
    sprinklingStartTime = -1; // Reset sprinkling start time
  }

  // Check if the entire background is black
  if (isBackgroundBlack()) {
    // Reset to the original pattern when the background is black
    resetToOriginalPattern();
  }
  noStroke();
}

void mousePressed() {
  // Check if the mouse click is within the bounds of any circle
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      float x = j * spacing + spacing / 2;
      float y = i * spacing + spacing / 2;

      if (dist(mouseX, mouseY, x, y) < circleRadius) {
        // Set the color of the clicked circle to black
        circleColors[j][i] = color(0);
      }
    }
  }

  // Create a burst of sprinkles at the mouse position
  for (int i = 0; i < 50; i++) {
    sprinkles.add(new Sprinkle(mouseX, mouseY));
  }

  // Set the sprinkling start time
  sprinklingStartTime = millis();
}

void resetToOriginalPattern() {
  // Initialize circle colors with a new set of colors
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      circleColors[j][i] = color(random(255), random(255), random(255));
    }
  }
}

boolean isBackgroundBlack() {
  // Check if every pixel in the canvas is black
  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    if (pixels[i] != color(0)) {
      return false;
    }
  }
  return true;
}

class Sprinkle {
  float x, y;
  float speedX, speedY;
  float angle; // Angle for line direction
  float length; // Length of the line
  color sprinkleColor;
  int creationTime;
  int lifetime = 2000; // Lifetime of the sprinkle lines in milliseconds

  Sprinkle(float x, float y) {
    this.x = x;
    this.y = y;
    this.speedX = random(-5, 5);
    this.speedY = random(-5, 5);
    this.angle = random(TWO_PI); // Random initial angle
    this.length = 10.0;

    // Set sprinkle color to black and blue
    int sprinkleColorType = int(random(2));
    if (sprinkleColorType == 0) {
      this.sprinkleColor = color(0); // Black
    } else {
      this.sprinkleColor = color(0, 0, 255); // Blue
    }

    this.creationTime = millis();
  }

  void update() {
    x += speedX;
    y += speedY;
    speedX *= 0.98;
    speedY *= 0.98;
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    strokeWeight(2);
    stroke(sprinkleColor);
    line(0, 0, length, 0);
    popMatrix();
  }

  boolean isExpired() {
    // Check if the sprinkle has exceeded its lifetime
    return millis() - creationTime > lifetime;
  }
}
