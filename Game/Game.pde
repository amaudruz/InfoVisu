
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
  camera(0, 0, depth, 0, 0, 0, 0, 1, 0);
  directionalLight(50, 100, 125, 0, -1, 0);
  ambientLight(102, 102, 102);
  background(200);
  
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
  speed = clamp(speed + e/10, 0, 5);
  if(speed == 0) {println("La vitesse de rotation égale 0 !");}
}