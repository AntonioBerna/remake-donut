color bg = color(209, 209, 209); // pink
float fps = 30;

HolePolygon donut;

void setup() {
  size(800, 800, P3D);
  background(bg);
  pixelDensity(displayDensity());
  frameRate(fps);
  smooth();

  donut = new HolePolygon(64, 64, 80, 150, color(0));
}

void draw() {
  background(bg);
  donut.animate(0.75, 0.01, 0.5);
}
