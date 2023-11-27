//1. SCREEN COORDINATES
//2. SYNTAX
//3. PROGRAM FLOW\TOP DOWN
//4. VARIABLES - GLOBAL LOCAL VARIABLES
//5. ARRAYS\ SRRAYLIST
//6. FUNCTIONS
//7. FOR LOOP\ WHILE LOOP\ IF-ELSE STATEMENT\ SWITCH
//8. MATH FUNCTIONS
//9. RANDOM AND NOISE
//10. SHAPE FUNCTIONS
//11. PUSH\POP MATRIX

float radius = 20.0;

void setup()
{
  size(400,400);
  background(255,0,0);
  stroke(0,255,0);
  fill(0,0,255);
  fill(0,0,random(255));
  fill(random(255),random(255),random(255));
  for(int I=0;I<10;I++)
  {
    for(int J=0;J<10;J++)
    {
      fill(random(255),random(255),random(255));
      ellipse(I*40+20,J*40+20,RADIUS,RADIUS);
    }
  }
}
