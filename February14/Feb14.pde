// Movers, an Attractor, abd a predator
ArrayList<Mover> movers = new ArrayList<Mover>();
Attractor a, r;

void setup() {
  // I wanted to see what it looked like if it filled my screen (almost)
  size(1800, 1000);
  for (int i = 0; i < 100; i++) {
    // Each Mover is initialized randomly.
    movers.add(new Mover(random(50, 100), // mass
      random(width), random(height))); // initial location
  }

  a = new Attractor();// to attract movers 
  r = new Attractor();// to repell other movers
}

void draw() {
  background(255);
  
  // For each mover
  for (int i = 0; i < movers.size(); i++) {

    // This is the part that I forgot to add in class:
    // Apply the attraction force from the Attractor on the mover, and the predator
    PVector aForce = a.attract(movers.get(i));
    PVector rForce = r.repell(movers.get(i));
    movers.get(i).applyForce(rForce);
    movers.get(i).applyForce(aForce);
    
    
    // making repeller eat the mover
      movers.get(i).update();
    movers.get(i).checkEdges();
    movers.get(i).display();
  
  // increasing food count when the mover gets in close proximity with the attractor
  if(dist(movers.get(i).location.x, movers.get(i).location.y, a.location.x, a.location.y) <= a.mass){
      movers.get(i).foodCount += 1;
    }
   
  if(movers.get(i).foodCount >=700){
    
    // changing the color if the mover has consumed enough food
    movers.get(i).myColor = 3;
  }
  
  if(movers.get(i).foodCount >=1700){
    // mitosis
    // older generation dies and new ones form
    movers.get(i).myColor = round(random(1));
    movers.get(i).foodCount = 0;
    
    // replication
    movers.add(new Mover(random(50, 100), // mass
      movers.get(i).location.x+20, movers.get(i).location.y+20)); // initial location
  }
    
    // making the predator eat the mover
    if(dist(movers.get(i).location.x, movers.get(i).location.y, r.location.x, r.location.y) <= r.mass){
      movers.remove(i);
    }
  }
  
  // displaying the attractor and predator 
  a.display();
  r.display();
}


class Attractor {
  float mass;
  PVector location;
  float G;

  Attractor() {
    location = new PVector(random(width-50), random(height-50));

    // mass and gravitational constant
    mass = 70;
    G = 0.4;
  }

  PVector attract(Mover m) {
    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();
    
    // constrain the distance
    // so that the mover doesn’t spin out of control.
    distance = constrain(distance, 5.0, 25.0);

    force.normalize();
    float strength = (G * mass * m.mass) / (distance * distance);
    force.mult(strength);
    return force;
  }
  
  PVector repell(Mover m){
    // getting mover direction
    PVector dir = PVector.sub(location, m.location);
    
    float distance = dir.mag();
    distance = constrain(distance,5,100);
    //[end]
    dir.normalize();
    // 3) Calculate magnitude.
    float force = 0.75 * (G * mass * m.mass) / (distance * distance);
    // 4) Make a vector out of direction and magnitude.
    dir.mult(force);
    return dir;
  }

  void display() {
    stroke(10);
    fill(175, 200, 200);
    ellipse(location.x, location.y, mass*2, mass*2);
  }
}


// Mover class from Monday with modifications:
// attract() method allows vehicles to attract or repel each other
// myColor sets the vehicle color
class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float G = 0.4;
  int myColor;
  int foodCount = 0;

  Mover(float _mass_, float _x_, float _y_) {
    mass = _mass_;
    location = new PVector(_x_, _y_);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    myColor = round(random(1));
  }

  // Newton’s second law.
  void applyForce(PVector force) {
    // Receive a force, divide by mass, and add to acceleration.
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  // The Mover now knows how to attract another Mover.
  PVector attract(Mover m) {

    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();
    distance = constrain(distance, 5.0, 25.0);
    force.normalize();

    float strength = (G * mass * m.mass) / (distance * distance);
    force.mult(strength);

    // If the color is different then we will be repelled
    if (myColor != m.myColor) force.mult(-1);

    return force;
  }


  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    stroke(0);
    if (myColor == 0) fill(255, 0, 0);
    else if(myColor == 1) fill (0, 0, 255);
    else fill(0, 255, 0);

    // Rotate the mover to point in the direction of travel
    // Translate to the center of the move
    pushMatrix();
    translate(location.x, location.y);
    rotate(velocity.heading());
    // pointing the triangle in the right direction
    triangle(0, 5, 0, -5, 20, 0);
    popMatrix();
  }

  // making the movers bounce off the edges

  void checkEdges() {
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1; // full velocity, opposite direction
      velocity.x *= 0.8; // lose a bit of energy in the bounce
    } else if (location.x < 0) {
      location.x = 0;
      velocity.x *= -1; // full velocity, opposite direction
      velocity.x *= 0.8; // lose a bit of energy in the bounce
    }

    if (location.y > height) {
      location.y = height;
      velocity.y *= -1; // full velocity, opposite direction
      velocity.y *= 0.8; // lose a bit of energy in the bounce
    } else if (location.y < 0) {
      location.y = 0;
      velocity.y *= -1; // full velocity, opposite direction
      velocity.y *= 0.8; // lose a bit of energy in the bounce
    }
  }
}
