class HolePolygon {
  int how_many, sides, radius, radius_axis, color_;

  HolePolygon(int how_many, int sides, int radius, int radius_axis, color color_) {
    this.how_many = how_many;
    this.sides = sides;
    this.radius = radius;
    this.radius_axis = radius_axis;
    this.color_ = color_;
  }

  void animate(float k, float speed, float thickness) {
    translate(width / 2, height / 2);
    rotateX(k * PI); // if k = 0.75 => k = 3/4, ...
    rotate(speed * frameCount);
    
    noFill();
    stroke(this.color_);
    strokeWeight(thickness);

    float rad_count = TWO_PI / this.how_many;
    float rad_sides = TWO_PI / this.sides;
    float frame_count = frameCount * 0.005;
    PVector[] vectors = new PVector[4];
    
    for (float i = 0; i < TWO_PI; i += rad_count) {
      PVector pos_axis = new PVector(sin(i + frame_count), 0, cos(i + frame_count));
      PVector n_pos_axis = new PVector(sin(i + rad_count + frame_count), 0, cos(i + rad_count + frame_count));
      for (float j = 0; j < TWO_PI; j += rad_sides) {
        PVector pos_radius = new PVector(sin(j + frame_count), cos(j + frame_count), sin(j + frame_count));
        PVector n_pos_radius = new PVector(sin(j + rad_sides + frame_count), cos(j + rad_sides + frame_count), sin(j + rad_sides + frame_count));
        
        vectors[0] = new PVector(
          this.radius_axis * pos_axis.x + radius * pos_axis.x * pos_radius.x,
          this.radius_axis * pos_axis.y + radius * pos_radius.y,
          this.radius_axis * pos_axis.z + radius * pos_axis.z * pos_radius.z
          );

        vectors[1] = new PVector(
          this.radius_axis * pos_axis.x + radius * pos_axis.x * n_pos_radius.x,
          this.radius_axis * pos_axis.y + radius * n_pos_radius.y,
          this.radius_axis * pos_axis.z + radius * pos_axis.z * n_pos_radius.z
          );

        vectors[2] = new PVector(
          this.radius_axis * n_pos_axis.x + radius * n_pos_axis.x * n_pos_radius.x,
          this.radius_axis * n_pos_axis.y + radius * n_pos_radius.y - noise(j),
          this.radius_axis * n_pos_axis.z + radius * n_pos_axis.z * n_pos_radius.z
          );

        vectors[3] = new PVector(
          this.radius_axis * n_pos_axis.x + radius * n_pos_axis.x * pos_radius.x,
          this.radius_axis * n_pos_axis.y + radius * pos_radius.y - noise(j),
          this.radius_axis * n_pos_axis.z + radius * n_pos_axis.z * pos_radius.z
          );

        beginShape();
        for (int l = 0; l < vectors.length; l++) {
          vertex(vectors[l].x, vectors[l].y, vectors[l].z);
        }
        endShape(CLOSE);
      }
    }
  }
};
