void settings() {
  size(1000, 1000, P3D);
  ball = new Ball();
  cylindre = new Cylindre();
}

void setup() {
  noStroke();
  cylindre.setup();
}

void draw() {
  if (placingCylinder){
    draw_placingCylinders();
  }else{
    draw_game();
  }
}

float clamp(float num, float min, float max) {
  if (num > max) {
    return max;
  } else if (num < min) {
    return min;
  } else {
    return num;
  }
}