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
  ball.checkCylindres();
  ball.display();
  popMatrix();

  for (int i = 0; i < positionCylindres.size(); i++) {
    pushMatrix();
    translate(positionCylindres.get(i).x, 0, positionCylindres.get(i).y);
    cylindre.display();
    popMatrix();
  }
}

void draw_placingCylinders() {
  translate(width/2, 0, height/2);
  camera(0, depth, 0, 0, 0, 0, 0, 0, -1);
  background(200);
  directionalLight(50, 100, 125, 0, 1, 0);
  ambientLight(102, 102, 102);
  box(box_size, box_thickness, box_size);

  rotateY(PI);

  if (mPressed) {
    pushMatrix();
    float X = (width/2 - mouseX)*f;
    float Y = -(height/2 - mouseY)*f;
    translate(clamp(X, -400, 400), 0, clamp(Y, -400, 400));
    cylindre.display();
    popMatrix();
  }

  for (int i = 0; i < positionCylindres.size(); i++) {
    pushMatrix();
    translate(positionCylindres.get(i).x, 0, positionCylindres.get(i).y);
    cylindre.display();
    popMatrix();
  }
}