Board B;
Animal A;
void setup(){
  size(400,400);
  B = new Board(20,20);
  A = new Animal(0,0,20,20);
  B.initiate();
  A.see(B.R,B.end);
  A.train(100000);
  background(255);
}


void draw(){
  A.display();
  B.display();
}


void mousePressed(){
  A.move();
}
