class Enemy {
  float mass;
  PVector location;
  float G;

  Enemy() {
    location = new PVector(mouseX, mouseY);
    // mass and gravitational constant
    mass = 100;
    G = 0.24;
  }
  // method to repel the movers 
  PVector repel(Mover m) {
    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();
    mass = constrain(mass, 100.0, 200.0);

    // constrain the distance
    // so that the mover doesn’t spin out of control.
    distance = constrain(distance, 5.0, 25.0);

    force.normalize();
    float strength = 0.75 * (-G * (mass) * (m.mass - (10))) / (distance * distance);
    force.mult(strength);
    return force;
  }

  void display() {
    stroke(10);
    fill(random(255), random(255), random(255));
    ellipse(location.x, location.y, mass/3, mass/2);
  }
}
