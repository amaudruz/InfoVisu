
float depth = 2000;
float scale = 1;
float rotX = 0;
float rotZ = 0;
float speed = 1;
float maxAngle = PI/3;
float box_thickness = 10;
float box_size = 800;
float gravityConstant = 1;

Ball ball;

void settings() {
  size(1000, 1000, P3D);
  ball = new Ball();
}

void setup() {
  noStroke();
}

void draw() {
  camera(0, depth, depth, 0, 0, 0, 0, 1, 0);
  directionalLight(50, 100, 125, 0, -1, 0);
  ambientLight(102, 102, 102);
  background(200);
  
  rotateX(rotX);
  rotateZ(rotZ);
  box(box_size, box_size, box_thickness);
  
  ball.update();
  ball.checkEdges();
  ball.display();
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