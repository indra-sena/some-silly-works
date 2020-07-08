
float r=200;
int total =0;
int In_circle =0;
double recordPi=0;

void setup(){
  size(400,400);
  background(0);
  translate(width/2,height/2);
  stroke(255);
  strokeWeight(4);
  noFill();
  circle(0,0,2*r);
  rectMode(CENTER);
  rect(0,0,2*r,2*r);
}

void draw(){
  translate(width/2,height/2);
  double Pi=0;
  for(int i=0;i<10000;i++){
    float x = random(-r,r);
    float y = random(-r,r);
    double d = (double)x*x+(double)y*y;
    total++;
    if(d<(double)r*r){
      In_circle++;
      stroke(100,255,0);
    }
    else{
     stroke(0,100,255); 
    }
    point(x,y);
  }
  Pi=4*((double)In_circle/total);
  double bestDiff = Math.abs(Math.PI - recordPi);
  double diff = Math.abs(Math.PI - Pi);
  if(diff<bestDiff){
    bestDiff=diff;
    recordPi=Pi;
    println(Pi);
  }
}
