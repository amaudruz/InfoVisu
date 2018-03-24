class Mover {
  PVector location;
  PVector velocity;
  PVector gravity;
  
  Mover() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(1, 1);
    gravity = new PVector(0, 1);
  }
  
  void update() {
    location.add(velocity);
    velocity.add(gravity);
  }
  
  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127);
    ellipse(location.x, location.y, 48, 48);
  }
  
  void checkEdges() {
    if (location.x > width){
      velocity.x = abs(velocity.x) * -1;
    } else if(location.x < 0) {
      velocity.x = abs(velocity.x);
    }
    
    if (location.y > height){
      velocity.y = abs(velocity.y) * -1;
    } else if (location.y < 0) {
      velocity.y = abs(velocity.y);
    }
  }
}