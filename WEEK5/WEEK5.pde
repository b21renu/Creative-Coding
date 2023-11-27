int total = 20;
float angle = 0;
float radius = 200;
float wide = 0;
float tall = 50;
float kolor = 0;

void setup()
{
  size(600,600);
  rectMode(CENTER);
  colorMode(HSB,100,100,100);
}

void draw()
{
  background(0);
  
  total = mouseX;
  radius = mouseY;
  
  angle = TWO_PI/total;
  
  wide = dist(radius*cos(0), radius*sin(0), radius*cos(angle), radius*sin(angle));
  
  for(float i=0;i<TWO_PI;i+=angle)
  {
    kolor = map(i,0,TWO_PI,0,100);
    
    //fill(kolor,100,100);
    //fill(100,100,kolor);
    fill(50,kolor,50);
    
    push();
    
    //translate(width/2,height/2);
    //translate(radius*cos(angle)+width/2,radius*sin(angle)+height/2);
    //translate(width/2,radius*sin(angle)+height/2);
    //translate(radius+cos(angle)*width/2,height/2);
    //translate(radius*10+width/2,radius*sin(angle)+height/2);
    //translate(radius*cos(angle)+height/2,radius*sin(angle)+height/2);
    //translate(radius*cos(i)+height/2,radius*sin(i)+height/2);
    translate((radius+tall*0.5)*cos(i)+height/2,(radius+tall*0.5)*sin(i)+height/2);
        
    rotate(i);
    
    //ellipse(width/2,height/2,10,10);
    //ellipse(0,0,50,50);
    
    //rect(0,0,20,40);
    //rect(0,0,30,wide);
    rect(0,0,tall,wide);
    
  pop();
  }
  //angle += 0.1;
}
