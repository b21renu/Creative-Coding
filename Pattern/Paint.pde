int numCircles = 20;
float[] circleSizes = new float[numCircles];
color[] circleColors = new color[numCircles];

ArrayList<Sprinkle> sprinkles = new ArrayList<Sprinkle>();
int sprinklingStartTime = -1; // -1 indicates no sprinkling

void setup() {
  size(600, 600);
  background(20);

  // Initialize circle sizes and colors
  for (int i = 0; i < numCircles; i++) {
    circleSizes[i] = random(20, 80);
    circleColors[i] = color(random(255), random(255), random(255), 200);
  }
}

void draw() {
  // Draw changing pattern
  for (int i = 0; i < numCircles; i++) {
    float x = random(width);
    float y = random(height);
    drawCuteCircle(x, y, circleSizes[i], circleColors[i]);
  }

  // Update and draw sprinkles
  for (int i = sprinkles.size() - 1; i >= 0; i--) {
    Sprinkle s = sprinkles.get(i);
    s.update();
    s.display();
    if (s.isOffScreen() || s.isExpired()) {
      sprinkles.remove(i);
    }
  }

  // Check if the sprinkling duration is over
  if (sprinklingStartTime != -1 && millis() - sprinklingStartTime > 5000) {
    sprinkles.clear(); // Remove all sprinkles after 5 seconds
    sprinklingStartTime = -1; // Reset sprinkling start time
  }
}

void drawCuteCircle(float x, float y, float size, color c) {
  fill(c);
  noStroke();
  ellipse(x, y, size, size);
}

void mousePressed() {
  // Change the pattern when the mouse is pressed
  background(20);
  for (int i = 0; i < numCircles; i++) {
    circleSizes[i] = random(20, 80);
    circleColors[i] = color(random(150), random(25), random(55), 150);
  }

  // Create a burst of sprinkles at the mouse position
  for (int i = 0; i < 50; i++) {
    sprinkles.add(new Sprinkle(mouseX, mouseY));
  }

  // Set the sprinkling start time
  sprinklingStartTime = millis();
}

class Sprinkle {
  float x, y;
  float speedX, speedY;
  float size;
  color sprinkleColor;
  int creationTime;

  Sprinkle(float x, float y) {
    this.x = x;
    this.y = y;
    this.speedX = random(-5, 5);
    this.speedY = random(-5, 5);
    this.size = random(5, 15);
    this.sprinkleColor = color(random(255), random(255), random(255), 200);
    this.creationTime = millis();
  }

  void update() {
    x += speedX;
    y += speedY;
    speedX *= 0.98; // Slow down over time
    speedY *= 0.98; // Slow down over time
  }

  void display() {
    fill(sprinkleColor);
    noStroke();
    ellipse(x, y, size, size);
  }

  boolean isOffScreen() {
    return x < 0 || x > width || y < 0 || y > height;
  }

  boolean isExpired() {
    // Check if the sprinkle has exceeded its lifetime (5 seconds)
    return millis() - creationTime > 5000;
  }
}
