int cols = 10;
int rows = 10;
float spacing;
static float bubbleRadius = 15; // Define bubbleRadius as a static variable
Bubble[][] bubbles;

ArrayList<Sprinkle> sprinkles = new ArrayList<Sprinkle>();
int sprinkleStartTime = -1; // Timer to track the start time of sprinkling
boolean[][] poppedBubbles; // Matrix to track popped bubbles

void setup() {
  size(400, 400);
  spacing = width / cols;
  initializeBubbleWrap();
}

void draw() {
  background(0);

  // Display and update the bubbles
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      Bubble bubble = bubbles[j][i];
      bubble.update();
      bubble.display();
    }
  }

  // Display and update the sprinkles
  for (int i = sprinkles.size() - 1; i >= 0; i--) {
    Sprinkle s = sprinkles.get(i);
    s.update();
    s.display();
    if (s.isExpired()) {
      sprinkles.remove(i);
    }
  }

  // Check if all bubbles are burst
  if (allBubblesBurst()) {
    initializeBubbleWrap();
  }

  // Check if the sprinkling duration is over
  if (sprinkleStartTime != -1 && millis() - sprinkleStartTime > 1000) {
    sprinkles.clear(); // Remove all sprinkles after 1 second
    sprinkleStartTime = -1; // Reset sprinkling start time
  }
}

void mousePressed() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      Bubble bubble = bubbles[j][i];
      if (bubble.checkBurst(mouseX, mouseY)) {
        // Add sprinkles when a bubble is clicked
        for (int k = 0; k < 20; k++) {
          sprinkles.add(new Sprinkle(bubble.x, bubble.y, bubble.bubbleColor));
        }
        // Set the sprinkling start time
        sprinkleStartTime = millis();
        // Mark the bubble as popped
        poppedBubbles[j][i] = true;
      }
    }
  }
}

void mouseDragged() {
  // Pop all bubbles in the line when dragging the mouse
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      Bubble bubble = bubbles[j][i];
      // Check if the bubble is not already popped and the mouse is in the line
      if (!poppedBubbles[j][i] && isMouseInLine(mouseX, mouseY, bubble.x, bubble.y, bubbleRadius)) {
        bubble.burst = true;
        // Add sprinkles when a bubble is dragged
        for (int k = 0; k < 20; k++) {
          sprinkles.add(new Sprinkle(bubble.x, bubble.y, bubble.bubbleColor));
        }
        // Mark the bubble as popped
        poppedBubbles[j][i] = true;
      }
    }
  }
}

void initializeBubbleWrap() {
  bubbles = new Bubble[cols][rows];
  poppedBubbles = new boolean[cols][rows]; // Initialize the matrix
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      float x = j * spacing + spacing / 2;
      float y = i * spacing + spacing / 2;
      int colorIndex = int(random(5));
      color bubbleColor = getColorByIndex(colorIndex);
      bubbles[j][i] = new Bubble(x, y, bubbleRadius, bubbleColor);
      poppedBubbles[j][i] = false; // Initialize the matrix values
    }
  }
}

color getColorByIndex(int index) {
  switch (index) {
    case 0:
      return color(255, 20, 147); // Deep Pink
    case 1:
      return color(147, 112, 219); // Medium Purple
    case 2:
      return color(0, 206, 209); // Dark Turquoise
    case 3:
      return color(119, 136, 153); // Light Slate Gray
    case 4:
      return color(255, 128, 128); // Coral
    default:
      return color(255); // Default color (white)
  }
}

boolean allBubblesBurst() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (!bubbles[j][i].isBurst()) {
        return false;
      }
    }
  }
  return true;
}

boolean isMouseInLine(float mx, float my, float bx, float by, float br) {
  // Check if the mouse is in the line
  float distance = dist(mx, my, bx, by);
  return distance < br;
}

class Bubble {
  float x, y;
  float radius;
  float fadeOutAlpha; // Variable to control the fading out
  boolean displayShine; // Flag to control whether the shine is displayed
  color bubbleColor;
  boolean burst;

  Bubble(float x, float y, float radius, color bubbleColor) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.fadeOutAlpha = 255; // Initialize fadeOutAlpha
    this.displayShine = true; // Initialize displayShine
    this.bubbleColor = bubbleColor;
    this.burst = false;
  }

  void update() {
    // Fade out gradually when burst
    if (burst && fadeOutAlpha > 0) {
      fadeOutAlpha -= 2;
    }
    // Disable shine when burst
    if (burst) {
      displayShine = false;
    }
  }

  void display() {
    // Draw the bubble
    noStroke();
    fill(bubbleColor, fadeOutAlpha);
    ellipse(x, y, radius * 2, radius * 2);

    // Draw reflections if displayShine is true
    if (displayShine) {
      for (int i = 0; i < 5; i++) {
        float reflectionAlpha = map(i, 0, 4, 0, 50); // Adjust the alpha value for reflection intensity
        fill(255, reflectionAlpha);
        ellipse(x, y - radius * 0.8, radius * 1.8, radius * 0.8);
      }

      // Draw highlight
      fill(255, 100);
      ellipse(x + radius * 0.5, y - radius * 0.5, radius * 0.8, radius * 0.8);
    }
  }

  boolean checkBurst(float px, float py) {
    if (!burst && dist(px, py, x, y) < radius) {
      burst = true;
      return true;
    }
    return false;
  }

  boolean isBurst() {
    return burst && fadeOutAlpha <= 0;
  }
}

class Sprinkle {
  float x, y;
  float speedX, speedY;
  float angle; // Angle for line direction
  float length; // Length of the line
  color sprinkleColor;
  float gravity; // Gravity effect for sprinkles
  int lifetime = 100; // Lifetime of the sprinkle lines in frames

  Sprinkle(float x, float y, color bubbleColor) {
    this.x = x;
    this.y = y;
    this.speedX = random(-2, 2);
    this.speedY = random(1, 5);
    this.angle = random(TWO_PI); // Random initial angle
    this.length = 3.0;
    this.sprinkleColor = bubbleColor;
    this.gravity = 0.1; // Adjust the gravity value
  }

  void update() {
    x += speedX;
    y += speedY;
    speedX *= 0.98;
    speedY += gravity; // Apply gravity
    speedY *= 0.98;
    lifetime--; // Decrease lifetime with each frame
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
    return lifetime <= 0;
  }
}
