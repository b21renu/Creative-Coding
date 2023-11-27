PFont regularFont;
PFont boldFont;
PFont italicFont;

void setup() {
  size(400, 200);
  
  // Load fonts
  regularFont = createFont("Arial", 54);
  boldFont = createFont("Arial Bold", 54);
  italicFont = createFont("Arial Italic", 54);
}

void draw() {
  background(255);
  
  // Display "I Love Myself" in regular font
  textFont(regularFont);
  textAlign(CENTER, TOP);
  fill(0);
  text("I Love Myself", width/2, 20);
  
  // Display "I Love Myself" in bold font
  textFont(boldFont);
  textAlign(CENTER, TOP);
  fill(255, 0, 0);
  text("I Love Myself", width/2, 80);
  
  // Display "I Love Myself" in italic font
  textFont(italicFont);
  textAlign(CENTER, TOP);
  fill(0, 0, 255);
  text("I Love Myself", width/2, 140);
}
