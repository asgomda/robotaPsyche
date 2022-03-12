// Mover class from Monday with modifications:
// attract() method allows vehicles to attract or repel each other
// myColor sets the vehicle color
class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  int aliveThreshold;
  float G = 0.01;
  int myColor;
  int moverKind;
  int foodCount = 0;
  float maxforce;
  float maxspeed;
  boolean displaying;

  Mover(float _x_, float _y_) {
    aliveThreshold = 50;
    displaying = true;
    location = new PVector(_x_, _y_);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    myColor = round(random(1));
    moverKind = round(random(2));
    maxspeed = 30;
    maxforce = 10;

    // depending on the kind of mover the mass changes
    if (moverKind == 2)
      mass = 150;
    else if (moverKind ==1)
      mass = 100;
    else
      mass = 50;
  }

  // Newton’s second law.
  void applyForce(PVector force) {
    // Receive a force, divide by mass, and add to acceleration.
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);

    return (steer);
  }

  // The Mover now knows how to attract another Mover.
  PVector attract(Mover m) {

    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();
    distance = constrain(distance, 5.0, 50.0);
    force.normalize();

    float strength = (G * mass * m.mass) / (distance * distance);
    force.mult(strength);

    // If the color is different then we will be repelled
    if (myColor != m.myColor) force.mult(-1);

    return force;
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

  // the arriving function
  PVector arrive(PVector target) {

    // First, calculate our desired velocity vector
    PVector desired = PVector.sub(target, location);

    // The distance is the magnitude of
    // the vector pointing from location to target.
    // Save this for later.
    float d = desired.mag();

    // As before, normalize the desired velocity vector
    desired.normalize();

    // Now apply the "arriving" logic

    // If we are closer than 100 pixels...
    if (d < 100) {

      // ...set the magnitude
      // according to how close we are.
      float m = map(d, 0, 100, 0, maxspeed);
      desired.mult(m);

      // Otherwise, proceed at full speed
    } else {
      desired.mult(maxspeed);
    }

    // The usual steering = desired - velocity
    PVector steer = PVector.sub(desired, velocity);

    // Limit to our maximum ability to steer
    steer.limit(maxforce);

    // and finally return it
    return(steer);
  }



  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    stroke(0);
    // Rotate the mover to point in the direction of travel
    // Translate to the center of the move
    pushMatrix();
    translate(location.x, location.y);
    rotate(velocity.heading());
    // pointing the triangle in the right direction
    // depending on the kind of mover the mass changes
    if (moverKind == 2) {
      fill(3, 89, 26);
      triangle(0, mass/10, 0, -mass/10, mass/4, 0);
      fill(225);
      ellipse(mass/8, 0, mass/12, mass/10);
    } else if (moverKind ==1) {
      fill (85, 4, 224);
      triangle(0, mass/10, 0, -mass/10, mass/4, 0);
      fill(225);
      ellipse(mass/8, 0, mass/12, mass/10);
    } else {
      fill(188, 224, 4);
      triangle(0, mass/10, 0, -mass/10, mass/4, 0);
      fill(225);
      ellipse(mass/8, 0, mass/12, mass/12);
    }

    popMatrix();
  }

  // making the movers appear on the opposite end of the screen

  void checkEdges() {
    if (location.x > width) {
      location.x = 0;
      //velocity.x *= -1; // full velocity, opposite direction
      velocity.x *= 0.2; // lose a bit of energy in the bounce
    } else if (location.x < 0) {
      location.x = width;
      //velocity.x *= -1; // full velocity, opposite direction
      velocity.x *= 0.2; // lose a bit of energy in the bounce
    }

    if (location.y > height) {
      location.y = 0;
      //velocity.y *= -1; // full velocity, opposite direction
      velocity.y *= 0.2; // lose a bit of energy in the bounce
    } else if (location.y < 0) {
      location.y = height;
      //velocity.y *= -1; // full velocity, opposite direction
      velocity.y *= 0.2; // lose a bit of energy in the bounce
    }
  }
}
