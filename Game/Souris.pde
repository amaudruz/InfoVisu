float speed = 0.8;

void mouseDragged() 
{
  int diffY = -(mouseY - pmouseY);
  if (diffY > 0) {
    rotX = clamp(rotX + 0.05*speed, -maxAngle, maxAngle);
  } else if (diffY < 0) {
    rotX = clamp(rotX - 0.05*speed, -maxAngle, maxAngle);
  }
  
  int diffX = mouseX - pmouseX;
  if (diffX > 0) {
    rotZ = clamp(rotZ + 0.05*speed, -maxAngle, maxAngle);
  } else if (diffX < 0) {
    rotZ = clamp(rotZ - 0.05*speed, -maxAngle, maxAngle);
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  speed = clamp(speed - e/10, 0, 5);
  if(speed == 0) {println("La vitesse de rotation égale 0 !");}
}

void mouseClicked() {
  if(placingCylinder){
    positionCylindres.add(new PVector(mouseX, mouseY));
  }
}