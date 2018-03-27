int window_size = 1000;
float depth = 2000;
float scale = 1;

float rotX = 0;
float rotZ = 0;
float maxAngle = PI/3;

float box_thickness = 10;
float box_size = 800;

float gravityConstant = 1;

float cylinderBaseSize = 50;
float cylinderHeight = 50;
int cylinderResolution = 40;
PShape topCylinder = new PShape();
PShape bottomCylinder = new PShape();
PShape openCylinder = new PShape();

float f = depth/window_size;

Ball ball;
Cylindre cylindre;

Boolean placingCylinder = false;
Boolean mPressed = false;

ArrayList<PVector> positionCylindres = new ArrayList<PVector>();