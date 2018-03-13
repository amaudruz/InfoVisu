class Ball {
  PVector location;
  PVector velocity;
  PVector gravity;

  int radius = 50;

  float normalForce = 1;
  float mu = 0.01;
  float frictionMagnitude = normalForce * mu;

  Ball() {
    location = new PVector(0, 0, 0);
    velocity = new PVector(0, 0, 0);
    gravity = new PVector(0, 0, 0);
  }

  void update() {
    PVector gravityForce = new PVector(0, 0, 0);
    
    gravityForce.x = sin(rotZ) * gravityConstant;
    gravityForce.z = sin(rotX) * gravityConstant;
    
    location.add(velocity);
    velocity.add(gravity);
  }

  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127);
    lights();
    sphere(radius);
  }

  void checkEdges() {
    if (location.x > width) {
      velocity.x = abs(velocity.x) * -1;
    } else if (location.x < 0) {
      velocity.x = abs(velocity.x);
    }

    if (location.y > height) {
      velocity.y = abs(velocity.y) * -1;
    } else if (location.y < 0) {
      velocity.y = abs(velocity.y);
    }
  }
}