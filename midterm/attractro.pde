class Attractor {
  float mass;
  PVector location;
  float G;

  Attractor() {
    location = new PVector(random(width-50), random(height-50));

    // mass and gravitational constant
    mass = 200;
    G = 0.45;
  }

  PVector attract(Mover m) {
    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();

    // constrain the distance
    // so that the mover doesn’t spin out of control.
    distance = constrain(distance, 5.0, 25.0);

    force.normalize();
    float strength = (G * (250 - mass) * m.mass) / (distance * distance);
    force.mult(strength);
    return force;
  }

  void display() {
    stroke(10);
    fill(149, 235, 52);
    ellipse(location.x, location.y, mass*2, mass*2);
  }
}
