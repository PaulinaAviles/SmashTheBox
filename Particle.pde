class Particle{
  Body body;
  float d;
  color c;

  // Constructor
  Particle(float x, float y) {
    d = 10;
    
    // Add the box to the box2d world
    makeBody(new Vec2(mouseX, mouseY), d);
    body.setUserData(this);
  }
  
  void display(color c_) {
    c = c_;
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(c);
    noStroke();
    ellipse(0, 0, d, d);
    popMatrix();
  }

  // This function adds the rectangle to the box2d world
  void makeBody(Vec2 center, float d)
  {
    
    

    // Define a polygon (this is what we use for a rectangle)
     BodyDef bd = new BodyDef();
    // Set its position
    bd.position.set(box2d.coordPixelsToWorld(center));
    bd.type = BodyType.DYNAMIC;
    body = box2d.createBody(bd);

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(d/2);
    
    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.2;
    fd.restitution = 0.4;
    
     body.createFixture(fd);

    // Give it some initial random velocity
    body.setLinearVelocity(new Vec2(-x, y));
    body.setAngularVelocity(random(-10, 10));
  }
  
  void killBody() {
    box2d.destroyBody(body);
  }
  
  boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y >= height-10) {
      killBody();
      return true;
    }
    return false;
  }
  
  void change(){
    col= color(random (255),random(255),random(255));
  }
  
  void rebota(){
    body.setLinearVelocity(new Vec2(0,-100)); //La nueva velocidad que le daré a mi cuerpo rígido, en función de un vector de dos dimensiones
  }
  
}//class