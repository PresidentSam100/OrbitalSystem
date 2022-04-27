ArrayList<ArrayList<Satellite>> bodies; //list of everything in this simulation that is going to interact
int dotsL = 1000; // greater value = slower but prettier, smaller (2 is minimum) = faster (you can change this as you wish)
int indexL = 0; //helps to trace paths 
float t = 0;
float rSum = 0;
int selector = 1; //you can change this to pick which systems you want to see (integer between 1 and 5)
float[][][][] dots;
final static float G = 8; //gravitational constant G
final static float it = .01; //time step
void setup() {
  bodies = new ArrayList<ArrayList<Satellite>>();
  size(800, 800);
  selector = 1;
  if (selector == 1) {
    //1: <planet and moon>
    bodies.add(new ArrayList<Satellite>());
    //if you want to try modifying the systems here are the variables you need to assign to make a body
    //new Satellite(xPosition from -400 to 400, yPosition from -400 to 400, xVelocity, yVelocity, mass, is the object fixed in space? true or false, color(RGB));
    bodies.get(0).add(new Satellite(0, 0, 0, 0, 300, false, color(255,0,0))); //sun: starts at origin with no velocity but a mass of 300, it is fixed in space, and its color is red
    bodies.get(0).add(new Satellite(0, 170, 30, 0, 10, false,color(0,0,255))); // planet 
    bodies.get(0).add(new Satellite(0, 180, 47, 0, .01, false,color(0,255,0))); // moon
   }
  else if (selector == 2) {
     //2: <black holes>
    bodies.add(new ArrayList<Satellite>());
    bodies.get(0).add(new Satellite(0, 40, 25, -25, 300, false, color(0,255,0)));
    bodies.get(0).add(new Satellite(0, -40, -25, 25, 300, false, color(0,255,0)));
    bodies.add(new ArrayList<Satellite>());
    bodies.get(1).add(new Satellite(0, 50, 25, -25, 300, false,color(0,0,255)));
    bodies.get(1).add(new Satellite(0, -50, -25, 25, 300, false, color(0,0,255)));
    bodies.add(new ArrayList<Satellite>());
    bodies.get(2).add(new Satellite(0, 30, 25, -25, 300, false, color(255,0,0)));
    bodies.get(2).add(new Satellite(0, -30, -25, 25, 300, false, color(255,0,0)));
  }
  else if (selector == 3) {
    //3: <Kepler's Second Law>
    //average distance: 102.68
    //period:  ??
    bodies.add(new ArrayList<Satellite>());
    bodies.get(0).add(new Satellite(0, 0, 0, 0, 300, true, color(0,255,0)));
    bodies.get(0).add(new Satellite(0, 140, 25, 0, 300, false, color(0,255,0)));
    bodies.add(new ArrayList<Satellite>());
    bodies.get(1).add(new Satellite(0, 0, 0, 0, 300, true, color(0,255,0),true));
    bodies.get(1).add(new Satellite(33.95648,127.74996,22.71653 ,-17.609762, 300, false, color(0,255,0)));
  }
  else if (selector == 4) {
    //4: <Kepler's Third Law>
    //average distance: 175.22
    //period: 27.37
    bodies.add(new ArrayList<Satellite>());
    bodies.get(0).add(new Satellite(0, 0, 0, 0, 300, true, color(0,255,0)));
    bodies.get(0).add(new Satellite(0, 110, 54, 0, 300, false, color(0,255,0)));
  }
  else if (selector == 5) {
    //5: <Sandbox>
    bodies.add(new ArrayList<Satellite>());
    bodies.get(0).add(new Satellite(0, 0, 0, 0, 300, true, color(0,255,0)));
    bodies.get(0).add(new Satellite(0, 170, 30, 0, 10, false,color(0,255,0)));
    bodies.get(0).add(new Satellite(0, 180, 52, 0, .1, false,color(0,255,0)));
  }
  dots = new float[dotsL][2][bodies.get(0).size()][bodies.size()];
}
void draw() {
  background(0);
  translate(width/2, height/2);
  for (int k = 0; k < bodies.size(); k++) {
    for (int i = 0; i < bodies.get(k).size(); i++) {
      for (int j = 0; j < bodies.get(k).size(); j++) {
        if (i != j && !bodies.get(k).get(i).returnStatic()) {
          bodies.get(k).get(i).iterate(bodies.get(k).get(j), it);
        }
      }
    }
    for (int i = 0; i < bodies.get(k).size(); i++) {
      if (!bodies.get(k).get(i).returnDuplicate()) {
        bodies.get(k).get(i).sketch();
        dots[indexL][0][i][k] = bodies.get(k).get(i).getX();
        dots[indexL][1][i][k] = bodies.get(k).get(i).getY();
        indexL++;
        if (indexL == dotsL-1) {
          indexL = 0;}
        drawDots();
      }
    }
  }
  if (selector == 3) {
    line(0,0,bodies.get(0).get(1).getX(),bodies.get(0).get(1).getY());
    line(0,0,bodies.get(1).get(1).getX(),bodies.get(1).get(1).getY());
  }
  t+= it;
}

void drawDots() {
  stroke(255);
  for (int k = 0; k < bodies.size(); k++) {
    for (int j = 0; j < bodies.get(k).size(); j++) {
      if (!bodies.get(k).get(j).returnStatic() && !bodies.get(k).get(j).returnDuplicate()) {
        for (int i = 0; i < dotsL; i++) {
          point(dots[i][0][j][k], dots[i][1][j][k]);
        }
      }
    }
  }
}
