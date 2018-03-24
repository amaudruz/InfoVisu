class Cylindre {
  PShape topCylinder = new PShape();
  PShape bottomCylinder = new PShape();
  PShape openCylinder = new PShape();

  void display() {
    shape(topCylinder);
    shape(bottomCylinder);
    shape(openCylinder);
  }

  void setup() {
    float angle;
    float[] x = new float[cylinderResolution + 1];
    float[] z = new float[cylinderResolution + 1];
    //get the x and y position on a circle for all the sides
    for (int i = 0; i < x.length; i++) {
      angle = (TWO_PI / cylinderResolution) * i;
      x[i] = sin(angle) * cylinderBaseSize;
      z[i] = cos(angle) * cylinderBaseSize;
    }
    openCylinder = createShape();
    openCylinder.beginShape(QUAD_STRIP);
    //draw the border of the cylinder
    for (int i = 0; i < x.length; i++) {
      openCylinder.vertex(x[i], box_thickness, z[i]);
      openCylinder.vertex(x[i], cylinderHeight, z[i]);
    }
    openCylinder.endShape();

    topCylinder = createShape();
    topCylinder.beginShape(TRIANGLE_FAN);
    //draw the top of the cylinder
    for (int i = 0; i < x.length-1; i++) {
      topCylinder.vertex(0, box_thickness, 0);
      topCylinder.vertex(x[i], box_thickness, z[i]);
      topCylinder.vertex(x[i+1], box_thickness, z[i+1]);
    }
    topCylinder.endShape();

    bottomCylinder = createShape();
    bottomCylinder.beginShape(TRIANGLE_FAN);
    //draw the bottom of the cylinder
    for (int i = 0; i < x.length-1; i++) {
      bottomCylinder.vertex(0, cylinderHeight, 0);
      bottomCylinder.vertex(x[i], cylinderHeight, z[i]);
      bottomCylinder.vertex(x[i+1], cylinderHeight, z[i+1]);
    }
    bottomCylinder.endShape();
  }
}