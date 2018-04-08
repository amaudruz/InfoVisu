float depth = 2000;
float scale = 1;
float rotX = 0.1;
float rotY = 0.1;

float sizeX = 100;
float sizeY = 150;
float sizeZ = 300;

// set-up
void settings() {
  size (1000, 1000, P2D);
}

void draw() {
  background(255, 255, 255);
  My3DPoint eye = new My3DPoint(-width/2, -height/2, -5000);
  My3DPoint origin = new My3DPoint(-sizeX*3/2, -sizeY, 0);
  My3DBox input3DBox = new My3DBox(origin, sizeX, sizeY, sizeZ);

  //rotate around x
  float[][] transform1 = rotateXMatrix(rotX);
  input3DBox = transformBox(input3DBox, transform1);
  //rotate around y
  float[][] transform2 = rotateYMatrix(rotY);
  input3DBox = transformBox(input3DBox, transform2);
  //translated
  float[][] transform3 = translationMatrix(100, 100, 0);
  input3DBox = transformBox(input3DBox, transform3);
  //scale
  float[][] transform4 = scaleMatrix(scale, scale, scale);
  input3DBox = transformBox(input3DBox, transform4);

  projectBox(eye, input3DBox).render();
}

//representation des points ds l'espace 2/3d
class My2DPoint {
  float x;
  float y;

  My2DPoint(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

class My3DPoint {
  float x;
  float y;
  float z;

  My3DPoint(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
}

My2DPoint projectPoint(My3DPoint eye, My3DPoint p) {
  float d = -p.z/eye.z + 1;
  return new My2DPoint(1/d*(p.x - eye.x), 1/d*(p.y - eye.y));
}

class My2DBox {
  My2DPoint[] s;
  My2DBox(My2DPoint[] s) {
    this.s = s;
  }

  void ligne(My2DPoint p1, My2DPoint p2) {
    line (p1.x, p1.y, p2.x, p2.y);
  }

  void render() {
    ligne(s[0], s[1]);
    ligne(s[1], s[2]);
    ligne(s[2], s[3]);
    ligne(s[3], s[0]);
    ligne(s[0], s[4]);
    ligne(s[3], s[7]);
    ligne(s[2], s[6]);
    ligne(s[1], s[5]);
    ligne(s[4], s[5]);
    ligne(s[5], s[6]);
    ligne(s[6], s[7]);
    ligne(s[7], s[4]);
  }
}

class My3DBox {
  My3DPoint[] p;
  My3DBox(My3DPoint origin, float dimX, float dimY, float dimZ) {
    float x = origin.x;
    float y = origin.y;
    float z = origin.z;
    this.p = new My3DPoint[]{
      new My3DPoint(x, y+dimY, z+dimZ), 
      new My3DPoint(x, y, z+dimZ), 
      new My3DPoint(x+dimX, y, z+dimZ), 
      new My3DPoint(x+dimX, y+dimY, z+dimZ), 
      new My3DPoint(x, y+dimY, z), 
      origin, 
      new My3DPoint(x+dimX, y, z), 
      new My3DPoint(x+dimX, y+dimY, z)
    };
  }

  My3DBox(My3DPoint[] p) {
    this.p = p;
  }
}

My2DBox projectBox (My3DPoint eye, My3DBox box) {
  return new My2DBox(new My2DPoint[]{
    projectPoint(eye, box.p[0]), 
    projectPoint(eye, box.p[1]), 
    projectPoint(eye, box.p[2]), 
    projectPoint(eye, box.p[3]), 
    projectPoint(eye, box.p[4]), 
    projectPoint(eye, box.p[5]), 
    projectPoint(eye, box.p[6]), 
    projectPoint(eye, box.p[7])
    });
}

float[] homogeneous3DPoint (My3DPoint p) {
  float[] result = {p.x, p.y, p.z, 1};
  return result;
}

float[][] rotateXMatrix(float angle) {
  return(new float[][] {{1, 0, 0, 0}, 
    {0, cos(angle), sin(angle), 0}, 
    {0, -sin(angle), cos(angle), 0}, 
    {0, 0, 0, 1}});
}

float[][] rotateYMatrix(float angle) {
  return(new float[][] {
    {cos(angle), 0, sin(angle), 0}, 
    {0, 1, 0, 0}, 
    {-sin(angle), 0, cos(angle), 0}, 
    {0, 0, 0, 1}});
}

float[][] rotateZMatrix(float angle) {
  return(new float[][] {
    {cos(angle), -sin(angle), 0, 0}, 
    {sin(angle), cos(angle), 0, 0}, 
    {0, 0, 1, 0}, 
    {0, 0, 0, 1}});
}

float[][] scaleMatrix(float x, float y, float z) {
  return(new float[][] { 
    {x, 0, 0, 0}, 
    {0, y, 0, 0}, 
    {0, 0, z, 0}, 
    {0, 0, 0, 1}});
}

float[][] translationMatrix(float x, float y, float z) {
  return(new float[][] {
    {1, 0, 0, x}, 
    {0, 1, 0, y}, 
    {0, 0, 1, z}, 
    {0, 0, 0, 1}});
}

float[] matrixProduct(float[][] a, float[] b) {
  // 4x4 by 4x1
  return(new float[]{
    a[0][0]*b[0] + a[0][1]*b[1] + a[0][2]*b[2] + a[0][3]*b[3], 
    a[1][0]*b[0] + a[1][1]*b[1] + a[1][2]*b[2] + a[1][3]*b[3], 
    a[2][0]*b[0] + a[2][1]*b[1] + a[2][2]*b[2] + a[2][3]*b[3], 
    a[3][0]*b[0] + a[3][1]*b[1] + a[3][2]*b[2] + a[3][3]*b[3]
    });
}

My3DBox transformBox(My3DBox box, float[][] transformMatrix) {  
  return new My3DBox(new My3DPoint[]{
    euclidian3DPoint(matrixProduct(transformMatrix, homogeneous3DPoint(box.p[0]))), 
    euclidian3DPoint(matrixProduct(transformMatrix, homogeneous3DPoint(box.p[1]))), 
    euclidian3DPoint(matrixProduct(transformMatrix, homogeneous3DPoint(box.p[2]))), 
    euclidian3DPoint(matrixProduct(transformMatrix, homogeneous3DPoint(box.p[3]))), 
    euclidian3DPoint(matrixProduct(transformMatrix, homogeneous3DPoint(box.p[4]))), 
    euclidian3DPoint(matrixProduct(transformMatrix, homogeneous3DPoint(box.p[5]))), 
    euclidian3DPoint(matrixProduct(transformMatrix, homogeneous3DPoint(box.p[6]))), 
    euclidian3DPoint(matrixProduct(transformMatrix, homogeneous3DPoint(box.p[7])))
    });
}

My3DPoint euclidian3DPoint (float[] a) {
  My3DPoint result = new My3DPoint(a[0]/a[3], a[1]/a[3], a[2]/a[3]);
  return result;
}

void mouseDragged() 
{
  int diff = mouseY - pmouseY;
  if(scale < 0) println("yes");
  if (diff > 0) {
    scale += 0.1;
  } else if (diff < 0) {
    if(scale > 0.2){
      scale -= 0.1;
    }
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      rotX += 0.1;
    } else if (keyCode == DOWN) {
      rotX += -0.1;
    } else if (keyCode == RIGHT) {
      rotY += 0.1;
    } else if (keyCode == LEFT) {
      rotY += -0.1;
    }
  }
}