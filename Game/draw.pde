void draw_game() {
  camera(0, 0, depth, 0, 0, 0, 0, -1, 0);
  directionalLight(50, 100, 125, 0, 1, 0);
  ambientLight(102, 102, 102);
  background(200);

  rotateX(rotX);
  rotateZ(rotZ);
  box(box_size, box_thickness, box_size);

  pushMatrix();
  ball.update();
  ball.checkEdges();
  ball.display();
  popMatrix();

  for (int i = 0; i < positionCylindres.size(); i++) {
    pushMatrix();
    translate(positionCylindres.get(i).x, positionCylindres.get(i).y, 0);
    // jojo
    cylindre.display();
    popMatrix();
  }
}

void draw_placingCylinders() {
  camera(0, depth, 0, 0, 0, 0, 0, 0, 1);
  background(200);
  directionalLight(50, 100, 125, 0, 1, 0);
  ambientLight(102, 102, 102);
  box(box_size, box_thickness, box_size);
}