
float depth = 2000;
float scale = 1;
float rotX = 0;
float rotZ = 0;
float speed = 1;
float maxAngle = PI/3;

void settings() {
  size(500, 500, P3D);
}
void setup() {
  noStroke();
}

void draw() {
  camera(width/2, height/2, depth, 250, 250, 0, 0, 1, 0);
  directionalLight(50, 100, 125, 0, -1, 0);
  ambientLight(102, 102, 102);
  background(200);
  
  translate(width/2, height/2, 0);
  rotX = clamp(map(mouseY, 0, height, -maxAngle -1, maxAngle +1) * speed, -maxAngle, maxAngle);
  rotZ = clamp(map(mouseX, 0, width, -maxAngle -1, maxAngle +1) * speed, -maxAngle, maxAngle);
  rotateX(rotX);
  rotateZ(rotZ);
  box(500, 500, 10);
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

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  speed += e/10;
}