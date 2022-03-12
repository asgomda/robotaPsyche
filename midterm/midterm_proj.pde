/*



*/



// Movers, an Attractor, abd a predator
ArrayList<Mover> movers = new ArrayList<Mover>();
ArrayList<Enemy> enemy = new ArrayList<Enemy>();

// The number of enemies per game
int ENEMY_COUNT = 5;

// the attractor object
Attractor a;

// font to display the text in
PFont font;

// game screen specification
int GAME_SCREEN = 1;

boolean firstIteration = false;

void setup() {

  //println(PFont.list());
  // using the desired font
  font = createFont("Osaka-Mono", 32);
  textFont(font);

  size(1800, 1000);

  //initializing the movers randomly
  for (int i = 0; i < 75; i++) {
    // Each Mover is initialized randomly.
    movers.add(new Mover(
      random(width), random(height))); // initial location
  }

  a = new Attractor();// to attract movers
}

void instructionsText() {
  //text
  fill(0);
  textAlign(CENTER);
  textSize(38);
  // displaying the on screen text instructions
  text("Instructions: " + "\n\n", 380, 150);
  textSize(25);
  text("1. There are three types of movers based on their sizes; "+ "\n"+"the biggest (green) is the most aggresive for food," + "\n"+ "followed by the purple, and the" + "\n" +

    " least aggresive is the yellow." + 
    "\n" +"2. On the mouse click, a new  enemy"+ 
    "\n"+" is created, and the movers" + " are repelled by the enemy " + 
    "\n"+ "3. The smallest movers are, also attracted"+ "\n" +" to the largest movers, as if for protection"  + 
    "\n"+ "4. The medium movers consume, the small"+ "\n" +" movers when largest movers, as if for protection"  + "\n" 
    , 400, 190);




  //text end
}
void draw() {
  background(230, 228, 257);
  instructionsText();
  // displaying a screen based on current game state
  if (GAME_SCREEN == 1) {
    instructionsText();
    // starting the home screen when the mouse is pressed
    text("START >>", 350, 700); 
    if ((mouseX>= 308 && mouseX<=396) && (mouseY>= 679 && mouseY<=705)) {
      noFill();
      stroke(255);
      rect(280, 670, 150, 40);

      if (mousePressed) {
        GAME_SCREEN = 2; // changing the screen to the home screen
        firstIteration = true; // to remove the mover created on click
      }
    }
  } else if (GAME_SCREEN == 2) {
    if (firstIteration && enemy.size() > 0) {
      // removing any enemies created by accidental mouse clicks before the start of the game
      for (int i=0; i< enemy.size(); i++)
        enemy.remove(0);
      firstIteration = false;
    }

    instructionsText();
    // For each mover
    for (int i = 0; i < movers.size(); i++) {
      // Apply the attraction force from the Attractor on the mover, and the predator
      // applying the repulsive force on the movers
      for (int e = 0; e < enemy.size(); e++) {
        PVector rForce = enemy.get(e).repel(movers.get(i));
        movers.get(i).applyForce(rForce);
      }



      // making the movers slow down towards the end of the screen
      PVector screenArrive = movers.get(i).arrive(new PVector(width, height));
      PVector screenEndArrive = movers.get(i).arrive(new PVector(0, 0));
      movers.get(i).applyForce(screenArrive);
      movers.get(i).applyForce(screenEndArrive);

      // making the movers arrive at the food source'
      PVector attractionForce = a.attract(movers.get(i));//.attract(a.location);
      movers.get(i).applyForce(attractionForce);
      PVector arriver = movers.get(i).arrive(a.location);
      movers.get(i).applyForce(arriver);

      // displaying the mover
      movers.get(i).update();
      movers.get(i).checkEdges();
      movers.get(i).display();

      // checking for collision between the food source and the mover
      if (dist(movers.get(i).location.x, movers.get(i).location.y, a.location.x, a.location.y) <= a.mass) {
        a.mass -= 0.1;

        // checking if the food is depleted and creating a new source
        if (a.mass <= 20) {
          //implementing the game of life rules 
          for (int j = 0; j < movers.size(); j++) {
            // the mover shouldn't count itself as another organism
            if (i!=j) {
              fill(0, 255, 255);
              // checking that the movers are close enough to reproduce

              if (dist(movers.get(i).location.x, movers.get(i).location.y, movers.get(j).location.x, movers.get(j).location.y) == (movers.get(i).mass + movers.get(j).mass)) {

                movers.add(new Mover(
                  ((movers.get(i).location.x + movers.get(j).location.x)/2), (movers.get(i).location.y +  movers.get(j).location.y)/2)); // initial location
              }
            }

            // making the smaller movers attracted to the larger movers 
            if (movers.get(i).mass == 150 && movers.get(j).mass == 50) {
              PVector bigMoverForce = movers.get(i).attract(movers.get(j));
              movers.get(j).applyForce(bigMoverForce);
            }

            // making the medium movers attracted to the smaller movers 
            if (movers.get(i).mass == 100 && movers.get(j).mass == 50) {
              PVector mediumMoverForce = movers.get(i).attract(movers.get(j));
              movers.get(i).applyForce(mediumMoverForce);
            }

            // making the small movers repelled to the smaller movers 
            if (movers.get(i).mass == 100 && movers.get(j).mass == 50) {
              PVector rMoverForce = movers.get(i).repel(movers.get(j));
              movers.get(j).applyForce(rMoverForce);
            }

            // making the medium mover consume the small mover
            if ((movers.get(i).mass == 100 && movers.get(j).mass == 50) && (dist(movers.get(i).location.x, movers.get(i).location.y, movers.get(j).location.x, movers.get(j).location.y) <= movers.get(i).mass/2)) {
              movers.remove(j);
              i--; // removing one mover from the global movers
            }
          }

          a = new Attractor();// to attract movers
        }
      }

      // increasing food count when the mover gets in close proximity with the attractor
      if (dist(movers.get(i).location.x, movers.get(i).location.y, a.location.x, a.location.y) <= a.mass) {
        movers.get(i).foodCount += 1;
      }

      if (movers.get(i).foodCount >=700) {

        // changing the color if the mover has consumed enough food
        movers.get(i).myColor = 3;
      }

      if (movers.get(i).foodCount >=1700) {
        // mitosis
        // older generation dies and new ones form
        movers.get(i).myColor = round(random(1));
        movers.get(i).foodCount = 0;

        // replication
        movers.add(new Mover(
          movers.get(i).location.x+20, movers.get(i).location.y+20)); // initial location
      }

      // making the predator eat the mover
      // making the enemy eat the movers 
      for (int e = 0; e < enemy.size(); e++) {
        // checking the distance between the enemy and the mover
        if (dist(movers.get(i).location.x, movers.get(i).location.y, enemy.get(e).location.x, enemy.get(e).location.y) <= enemy.get(e).mass/4) {
          movers.remove(i);
          enemy.get(e).mass += 10;
          i--;
        }
      }
    }

    // displaying the attractor and predator 
    a.display();

    // displaying the enemy
    for (int i = 0; i < enemy.size(); i++) {
      enemy.get(i).display();
    }
  }
}


void drawText(String text) {
  fill(0, 255, 255);
  textSize(128);
  text(text, 40, 240);
}

void mouseClicked() {
  enemy.add(new Enemy());
}
