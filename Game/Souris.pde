float speed = 0.8;

void mouseDragged() 
{
  if (!placingCylinder) {
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
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  speed = clamp(speed - e/10, 0, 5);
  if (speed == 0) {
    println("La vitesse de rotation égale 0 !");
  }
}

//void mouseClicked() {
//  if (placingCylinder) {
//    positionCylindres.add(new PVector(clamp((width/2 - mouseX), -400, 400), clamp(-(height/2 - mouseY), -400, 400)));
//    println(width/2 + " - " + mouseX + " -- " + (width/2 - mouseX)*(box_size/width) +" --- " + height/2 + " - " + mouseY);
//  }
//}

void mousePressed() {
  mPressed = true;
}

void mouseReleased() {
  mPressed = false;
  if (placingCylinder) {
    float X = (width/2 - mouseX)*f;
    float Y = -(height/2 - mouseY)*f;
    positionCylindres.add(new PVector(clamp(X, -400, 400), clamp(Y, -400, 400)));
  }
}