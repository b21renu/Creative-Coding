int cols;
int rows;
float spacing;
static float bubbleRadius = 15;
Bubble[][] bubbles;

PFont boldFont;

ArrayList<Sprinkle> sprinkles = new ArrayList<Sprinkle>();
int sprinkleStartTime = -1;
boolean[][] poppedBubbles;

int roundCount = 1;
int displayTime = 3000;
int resetTime = -1;

void setup() {
  size(300, 200);
  cols = floor((width - bubbleRadius) / (2 * bubbleRadius));
  rows = floor((height - bubbleRadius) / (2 * bubbleRadius));
  spacing = (width - bubbleRadius) / cols + 0.6;
  initializeBubbleWrap();
  boldFont = createFont("Arial Bold", 54);
}

void draw() {
  background(0);

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      Bubble bubble = bubbles[j][i];
      bubble.update();
      bubble.display();
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

  if (allBubblesBurst()) {
    displayLevelCompletedMessage();
    if (resetTime == -1) {
      resetTime = millis();
    } else if (millis() - resetTime > displayTime) {
      initializeBubbleWrap();
      roundCount++;
      resetTime = -1;
    }
  } else {
    resetTime = -1;
  }
}

void mousePressed() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      Bubble bubble = bubbles[j][i];
      if (bubble.checkBurst(mouseX, mouseY)) {
        for (int k = 0; k < 100; k++) {
          sprinkles.add(new Sprinkle(bubble.x, bubble.y, random(TWO_PI), bubble.bubbleColor));
        }
        sprinkleStartTime = millis();
        poppedBubbles[j][i] = true;
      }
    }
  }
}

void mouseDragged() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      Bubble bubble = bubbles[j][i];
      if (!poppedBubbles[j][i] && isMouseInLine(mouseX, mouseY, bubble.x, bubble.y, bubbleRadius)) {
        bubble.burst = true;
        for (int k = 0; k < 20; k++) {
          sprinkles.add(new Sprinkle(bubble.x, bubble.y, random(TWO_PI), bubble.bubbleColor));
        }
        poppedBubbles[j][i] = true;
      }
    }
  }
}

void initializeBubbleWrap() {
  bubbles = new Bubble[cols][rows];
  poppedBubbles = new boolean[cols][rows];
  
  float extraSpaceX = (width - cols * spacing) / 2; // Calculate extra space on X-axis
  float extraSpaceY = (height - rows * spacing) / 2; // Calculate extra space on Y-axis

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      float x = extraSpaceX + j * spacing + spacing / 2;
      float y = extraSpaceY + i * spacing + spacing / 2;
      int colorIndex = int(random(5));
      color bubbleColor = getColorByIndex(colorIndex);
      bubbles[j][i] = new Bubble(x, y, bubbleRadius, bubbleColor);
      poppedBubbles[j][i] = false;
    }
  }
}

color getColorByIndex(int index) {
  switch (index) {
    case 0:
      return color(255, 20, 147);
    case 1:
      return color(147, 112, 219);
    case 2:
      return color(0, 206, 209); 
    case 3:
      return color(119, 136, 153);
    case 4:
      return color(255, 128, 128);
    default:
      return color(255);
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

void displayLevelCompletedMessage() {
  float textSizeFactor = width / 800.0;
  int adjustedTextSize = int(120 * textSizeFactor);

  textFont(boldFont);
  fill(148, 87, 235);
  textSize(adjustedTextSize);
  textAlign(CENTER, CENTER);
  text("Level " + roundCount + "\nCompleted", width / 2, height / 2);
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
      fadeOutAlpha -= 5;
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

  Sprinkle(float x, float y, float angle, color bubbleColor) {
    this.x = x;
    this.y = y;
    this.angle = angle;
    this.speedX = random(-2, 2);
    this.speedY = random(1, 5);
    this.angle = random(TWO_PI); // Random initial angle
    //this.speedX = cos(angle) * 5;
    //this.speedY = sin(angle) * 5;
    this.length = 3.0;
    this.sprinkleColor = bubbleColor;
    this.gravity = 0.1;
  }

  void update() {
    x += speedX;
    y += speedY;
    speedX *= 0.98;
    speedY += gravity;
    speedY *= 0.98;
    lifetime--;

    //y += gravity * lifetime;
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    strokeWeight(2);
    stroke(sprinkleColor);
    line(0, 0, length, 0);
    
    noStroke();
    //fill(sprinkleColor);
    //ellipse(0, 0, 2, 2);
    
    popMatrix();
  }

  boolean isExpired() {
    return lifetime <= 0;
  }
}
