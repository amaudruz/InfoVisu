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
      float distZ = abs(positionCylindres.get(i).y - (location.z + velocity.z));
      float dist = sqrt(distX * distX + distZ * distZ);
      if (dist <= radius + cylinderBaseSize) {
       // println("Avant : " + location.x + "; " +location.y + "; " + location.z);
        //println("Avant cylindre :" + positionCylindres.get(i).x + "; " +positionCylindres.get(i).y + "; " + positionCylindres.get(i).z);
        //println("Avant  Vitesse : " + velocity.x + "; " +velocity.y + "; " + velocity.z);

         // calcul du vecteur n 
        float nX = -positionCylindres.get(i).x + (location.x + velocity.x);
        float nZ = -positionCylindres.get(i).y + (location.z + velocity.z);
        float sizeofN = sqrt(nX*nX + nZ*nZ);
        //println("sizeof : " + sizeofN);
        
        // normalisation du vecteur n
        nX = (nX/sizeofN) ; 
        nZ = (nZ/sizeofN) ;
        //sizeofN = sqrt(nX*nX + nZ*nZ);
         //println(sizeofN);

        float scalar = 2*((velocity.x * nX) + (velocity.z * nZ)); // le produit scalaire dans la formule 
        float vit = sqrt((velocity.x *  velocity.x) + ( velocity.z *  velocity.z));
      
        velocity.x = velocity.x - 2*scalar*(nX);
        velocity.z = velocity.z - 2*scalar*(nZ);
        float thisvit = sqrt((velocity.x *  velocity.x) + ( velocity.z *  velocity.z));
  
         velocity.x = velocity.x *vit/thisvit * coeff_rebond;
         velocity.z = velocity.z *vit/thisvit * coeff_rebond;
       
        // on remet la balle au bord du cylindre
        location.x = positionCylindres.get(i).x + (cylinderBaseSize+ radius)*nX;  
        location.z = positionCylindres.get(i).y + (cylinderBaseSize+ radius)*nZ;
       
      }
    }
  }
}