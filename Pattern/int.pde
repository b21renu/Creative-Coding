int cols, rows;
float scl = 20;
float w = 1400;
float h = 800;

void setup() {
  size(500, 500);
  cols = floor(w / scl);
  rows = floor(h / scl);
}

void draw() {
  background(0);
  translate(width / 2, height / 2);

  for (int i = -cols; i < cols; i++) {
    for (int j = -rows; j < rows; j++) {
      float x = i * scl + cos(frameCount * 0.01 + i) * 20;
      float y = j * scl + sin(frameCount * 0.01 + j) * 20;
      float r = map(sin(frameCount * 0.02 + i + j), -1, 1, 0, 255);
      float g = map(cos(frameCount * 0.02 + i - j), -1, 1, 0, 55);
      float b = map(sin(frameCount * 0.02 + j), -1, 1, 0, 150);

      fill(r, g, b);
      noStroke();
      ellipse(x, y, scl, scl);
    }
  }
}
