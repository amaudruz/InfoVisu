void keyPressed() {
  if (key == CODED) {
    if (keyCode == SHIFT) {
      placingCylinder = true;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == SHIFT) {
      placingCylinder = false;
    }
  }
}