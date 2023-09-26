class HolePolygon {
  color white = color(255, 255, 255);
  int how_many, sides, radius, radius_axis;

  HolePolygon(int how_many, int sides, int radius, int radius_axis) {
    this.how_many = how_many;
    this.sides = sides;
    this.radius = radius;
    this.radius_axis = radius_axis;
  }

  void animate(float k, float speed, float thickness) {
    background(black);
    translate(width / 2, height / 2);
    rotateX(k * PI); // if k = 0.75 => k = 3/4, ...
    rotate(speed * frameCount);
    noFill();
    stroke(white);
    strokeWeight(thickness);

    float rad_count = TWO_PI / this.how_many;
    float rad_sides = TWO_PI / this.sides;
    float frame_count = frameCount * 0.005;

    for (float i = 0; i < TWO_PI; i += rad_count) {
      PVector pos_axis = new PVector(sin(i + frame_count), 0, cos(i + frame_count));
      PVector n_pos_axis = new PVector(sin(i + rad_count + frame_count), 0, cos(i + rad_count + frame_count));
      for (float j = 0; j < TWO_PI; j += rad_sides) {
        PVector pos_radius = new PVector(sin(j + frame_count), cos(j + frame_count), sin(j + frame_count));
        PVector n_pos_radius = new PVector(sin(j + rad_sides + frame_count), cos(j + rad_sides + frame_count), sin(j + rad_sides + frame_count));

        PVector v1 = new PVector(
          this.radius_axis * pos_axis.x + radius * pos_axis.x * pos_radius.x,
          this.radius_axis * pos_axis.y + radius * pos_radius.y,
          this.radius_axis * pos_axis.z + radius * pos_axis.z * pos_radius.z
          );

        PVector v2 = new PVector(
          this.radius_axis * pos_axis.x + radius * pos_axis.x * n_pos_radius.x,
          this.radius_axis * pos_axis.y + radius * n_pos_radius.y,
          this.radius_axis * pos_axis.z + radius * pos_axis.z * n_pos_radius.z
          );

        PVector v3 = new PVector(
          this.radius_axis * n_pos_axis.x + radius * n_pos_axis.x * n_pos_radius.x,
          this.radius_axis * n_pos_axis.y + radius * n_pos_radius.y - noise(j),
          this.radius_axis * n_pos_axis.z + radius * n_pos_axis.z * n_pos_radius.z
          );

        PVector v4 = new PVector(
          this.radius_axis * n_pos_axis.x + radius * n_pos_axis.x * pos_radius.x,
          this.radius_axis * n_pos_axis.y + radius * pos_radius.y - noise(j),
          this.radius_axis * n_pos_axis.z + radius * n_pos_axis.z * pos_radius.z
          );

        beginShape();
        vertex(v1.x, v1.y, v1.z);
        vertex(v2.x, v2.y, v2.z);
        vertex(v3.x, v3.y, v3.z);
        vertex(v4.x, v4.y, v4.z);
        endShape(CLOSE);
      }
    }
  }
};
