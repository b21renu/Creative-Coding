int cols = 12;
int rows = 12;
float spacing;
float bubbleRadius = 16;
Bubble[][] bubbles;

void setup() {
  size(400, 400);
  spacing = width / cols;
  initializeBubbleWrap();
}

void draw() {
  background(0);

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      Bubble bubble = bubbles[j][i];
      bubble.display();
    }
  }

  if (allBubblesBurst()) {
    initializeBubbleWrap();
  }
}

void mousePressed() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      Bubble bubble = bubbles[j][i];
      bubble.checkBurst(mouseX, mouseY);
    }
  }
}

void initializeBubbleWrap() {
  bubbles = new Bubble[cols][rows];
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      float x = j * spacing + spacing / 2;
      float y = i * spacing + spacing / 2;
      int colorIndex = int(random(5));
      color bubbleColor = getColorByIndex(colorIndex);
      bubbles[j][i] = new Bubble(x, y, bubbleRadius, bubbleColor);
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

class Bubble {
  float x, y;
  float radius;
  color bubbleColor;
  boolean burst;

  Bubble(float x, float y, float radius, color bubbleColor) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.bubbleColor = bubbleColor;
    this.burst = false;
  }

  void display() {
    if (!burst) {
      fill(bubbleColor);
      stroke(0);
      ellipse(x, y, radius * 2, radius * 2);
    }
  }

  void checkBurst(float px, float py) {
    if (!burst && dist(px, py, x, y) < radius) {
      burst = true;
    }
  }

  boolean isBurst() {
    return burst;
  }
}
