int cols, rows;
int scale = 20;
int w = 2400;
int h = 2400;

float flying = 0;

float[][] terrain;

void setup() {
  size(800, 800, P3D);
  cols = w/scale;
  rows = h/scale;
  // generate an array with the rows and columns. This will be filled by noise data for the z value of the terrain
  terrain = new float[cols][rows];
}

void draw() {
  background(255);
  // we need to translate the canvas so the landscape is drawn from the middle
  translate(width/2, height/2 - -151);
  //we rotate by a third of pie to get a nice view
  rotateX(PI/3);
  //rotateZ(-PI/4);
  lights();

  //we do this so the landscape is actually centered.
  translate(-w/2, -h/2 - 863);

  // flying is the value we will be tweaking to create the offset in the noise algorithm
  flying -= 0.2;

  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      // generate a noise value for the vertex
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      // we need to change the offset values for each vertice, or else the noise value would be the same.
      xoff += 0.2;
    }
    yoff += 0.2;
  }

  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      noStroke();
      fill(142, 241, 255);
      vertex(x*scale, y*scale, terrain[x][y]);
      // the reason why the sewcond vertex is drawn with a y+1, is because we need to draw the vertex with a pattern of up down, and start the vertex on the next row
      vertex(x*scale, (y+1)*scale, terrain[x][y+1]);
    }
    endShape();
  }
}
