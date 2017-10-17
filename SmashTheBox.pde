import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

float x;
float y;
color col;
PFont font;
PFont font2;
int counter=0;

// A reference to our box2d world
Box2DProcessing box2d;

//ArrayList <Box> boxes;
ArrayList <Particle> particles;
ArrayList <Boundary> boundaries;

Box box;

void setup(){
  size(900,500);
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  box2d.listenForCollisions();
  
  box2d.setGravity(0, -7);
  
  //boxes = new ArrayList<Box>();
  particles = new ArrayList<Particle>();
  boundaries = new ArrayList<Boundary>();
  
  boundaries.add(new Boundary(width/2,10,width,5));
  boundaries.add(new Boundary(width/2,height-10,width,5));
  boundaries.add(new Boundary(10,height/2,5,height));
  boundaries.add(new Boundary(width-10,height/2,5,height));
  
  box = new Box(width/2,height/2);
  
   background(200);
  
  font = loadFont("1942report-48.vlw");
  font2=loadFont("OstrichSans-Medium-48.vlw");
}//setup

void draw(){
  background(200);

  textFont(font, 12);
  fill(100);
  textAlign(CENTER,CENTER);
  text("Click en la línea. Estira. Suelta", width/2, 70);
  
  textFont(font, 28);
  fill(50);
  textAlign(CENTER,CENTER);
  text("Smash the box", width/2, 50);
  
  textFont(font2, 50);
  fill(247,241,157);
  textAlign(CENTER,CENTER);
  text(counter, 5*width/6, 50);
  
  fill(0);
  
    ellipse(width/2+30,height/2,5,5);
    ellipse(width/2-30,height/2,5,5);
    line(width/2+30,height/2,width/2-30,height/2);
  
  box2d.step();
  
  if(mousePressed == true){
    stroke(0);
    line(width/2+30,height/2,mouseX,mouseY);
    line(width/2-30,height/2,mouseX,mouseY);
  }
  
  
  x = mouseX-width/2;
  y = mouseY-height/2;
  x = x/3;
  y = y/3;
  
  for (Particle p: particles) {
    p.display(col);
  }
  
  box.display();
  
  for (Boundary wall: boundaries) {
    wall.display();
  }
}//draw


void mouseReleased(){
  Particle p = new Particle(mouseX,mouseY);
  particles.add(p);
  p.change();
}


void beginContact(Contact cp) {

  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();

  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  
  if(o1.getClass() == Particle.class && o2.getClass()==Box.class){  //cuadro obj 1
    Particle p = (Particle) o1;
    box.change(col);
    counter+=1;
    particles.remove(p);
    p.done();
  }
  
  if(o1.getClass() == Box.class && o2.getClass()==Particle.class){  //cuadro obj 2
    Particle p = (Particle) o2;
    box.change(col);
    counter+=1;
    particles.remove(p);
    p.done();
  }


}//

  void endContact(Contact cp) {
  }