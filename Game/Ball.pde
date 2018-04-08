class Ball {
  PVector location;
  PVector velocity;
  PVector gravity;

  int radius = 50;
  float coeff_rebond = 0.5;

  float normalForce = 1;
  float mu = 0.01;
  float frictionMagnitude = normalForce * mu;

  Ball() {
    location = new PVector(0, 50, 0);
    velocity = new PVector(0, 0, 0);
    gravity = new PVector(0, 0, 0);
  }

  void update() {
    PVector gravity = new PVector(0, 0, 0);

    gravity.x = sin(-rotZ) * gravityConstant;
    gravity.z = sin(rotX) * gravityConstant;

    location.add(velocity);
    velocity.add(gravity);

    PVector friction = velocity.copy();
    friction.mult(-1);
    friction.normalize();
    friction.mult(frictionMagnitude);
    velocity.add(friction);

    translate(location.x, location.y, location.z);
  }

  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127);
    lights();
    sphere(radius);
  }

  void checkEdges() {
    if (location.x > box_size/2 - radius) {
      velocity.x = coeff_rebond * abs(velocity.x) * -1;
    } else if (location.x < -box_size/2 + radius) {
      velocity.x = coeff_rebond * abs(velocity.x);
    }

    if (location.z > box_size/2 - radius) {
      velocity.z = coeff_rebond * abs(velocity.z) * -1;
    } else if (location.z < -box_size/2 + radius) {
      velocity.z = coeff_rebond * abs(velocity.z);
    }
  }

  void checkCylindres() {
    for (int i = 0; i < positionCylindres.size(); i++) {
      float distX = abs(positionCylindres.get(i).x - (location.x + velocity.x));
      float distZ = abs(positionCylindres.get(i).z - (location.z + velocity.z));
      float dist = sqrt(distX * distX + distZ * distZ);
      if (dist <= radius + cylinderBaseSize) {
        
      }
    }
  }
}