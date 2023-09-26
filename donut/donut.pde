color black = color(0, 0, 0);
float fps = 30;

HolePolygon donut;

void setup() {
  size(800, 800, P3D);
  background(black);
  pixelDensity(displayDensity());
  frameRate(fps);
  smooth();

  donut = new HolePolygon(64, 64, 80, 150);
}

void draw() {
  donut.animate(0.75, 0.01, 1.0);
}
