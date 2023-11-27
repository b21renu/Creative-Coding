int cols = 10;
int rows = 10;
float spacing;
float circleSize;
color[][] circleColors;
float colorIncrement = 0.1;
float animationDuration = 30.0;  // Total animation duration in seconds
int burstStartTime = 0;
boolean isBursting = false;
color burstColor;
boolean smiley = false;
int smileyStartTime = 0;

void setup() {
  size(400, 400);
  spacing = width / cols;
  circleSize = spacing * 0.8;
  circleColors = new color[cols][rows];
  noStroke();
  frameRate(30);

  // Initialize colors with a base blue
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      circleColors[j][i] = color(0, 0, 100);
    }
  }
}

void draw() {
  background(0);  // Black background
  float elapsedTime = millis() / 1000.0;  // Elapsed time in seconds

  if (!isBursting && !smiley) {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        float x = j * spacing + spacing / 2;
        float y = i * spacing + spacing / 2;

        // Calculate individual blinking intervals
        float blinkingInterval = map(
          noise(j, i, elapsedTime), 0, 1, 0, animationDuration
        );

        // Increase blue component gradually with time
        float b = blue(circleColors[j][i]) + colorIncrement;
        circleColors[j][i] = color(0, 0, constrain(b, 0, 255));

        // Blinking effect with individual intervals
        if (int(elapsedTime / blinkingInterval) % 2 == 0) {
          fill(circleColors[j][i]);
        } else {
          noFill();
        }

        ellipse(x, y, circleSize, circleSize);
      }
    }

    if (millis() - burstStartTime >= 15000) { // 15 seconds
      isBursting = true;
      burstStartTime = millis();
      burstColor = color(random(255), random(255), random(255)); // Random burst color
    }

    if (millis() - smileyStartTime >= 30000) { // 30 seconds
      smiley = true;
      smileyStartTime = millis();
    }
  } 
  
  else if (isBursting) {
    // Burst effect
    float burstDuration = 2.0; // Duration of the burst effect
    float burstElapsedTime = (millis() - burstStartTime) / 1000.0;
    
    if (burstElapsedTime <= burstDuration) {
      // Display burst effect
      float centerX = width / 2;
      float centerY = height / 2;

      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
          float x = j * spacing + spacing / 2;
          float y = i * spacing + spacing / 2;
          float distance = dist(x, y, centerX, centerY);

          if (distance <= burstElapsedTime * 50) {
            fill(burstColor);
          } else {
            noFill();
          }

          ellipse(x, y, circleSize, circleSize);
        }
      }
    } 
    
    else {
      // Burst effect is over, reset for the next cycle
      isBursting = false;
      burstStartTime = millis();
    }
  }
  
  else if (smiley) {
    // Draw a smiley face for 10 seconds
    if (millis() - smileyStartTime <= 10000) {
      drawSmileyFace();
    } else {
      smiley = false;
      burstStartTime = millis();
    }
  }
}

void drawSmileyFace() {
  float centerX = width / 2;
  float centerY = height / 2;
  fill(255, 255, 0); // Yellow face
  ellipse(centerX, centerY, 200, 200);  // Face
  fill(0);
  ellipse(centerX - 50, centerY - 50, 40, 40);  // Left eye
  ellipse(centerX + 50, centerY - 50, 40, 40);  // Right eye
  arc(centerX, centerY + 30, 120, 80, radians(0), radians(180));  // Smile
}
