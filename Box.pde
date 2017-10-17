
class Box{
   // We need to keep track of a Body and a width and height
  Body body;
  
  float x;
  float y;
  float w;
  float h;
  color c=60;
  float xoff = 0; //valores para el noise
float yoff = 1500;
  
  Box(float x_, float y_) {
      x = x_;
      y = y_;
      
      w = 30;
      h = 30;
      
  float x = noise(xoff)*width;
  float y = noise(yoff)*height;
  xoff += 0.5;
  yoff += 0.5;
      
      // Add the box to the box2d world
    makeBody(new Vec2(x, y), w, h);
    body.setUserData(this);
  }
  
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();

    rectMode(PConstants.CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(c);
    noStroke();
    rect(0, 0, w, h);
    popMatrix();
  }
  
  
   void makeBody(Vec2 center, float w_, float h_) {
     
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);

    // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    
    fd.density = .1;
    fd.friction = 0;
    fd.restitution = 1;

    body.createFixture(fd);

    // Give it some initial random velocity
    body.setLinearVelocity(new Vec2(random(-10, 10), random(5, 7)));
    body.setAngularVelocity(random(-10, 10));
  }
  
  void change(color c_){
   c=c_;
  }
 
   

}//class