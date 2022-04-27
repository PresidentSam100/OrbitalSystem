class Satellite {
  float x;
  float y;
  float dx;
  float dy;
  float m;
  color c1;
  boolean isStatic, isDuplicate;
  Satellite(float x1, float y1, float dx1, float dy1, float m1, boolean y, color c) {
    this.c1 = c;
    this.x = x1;
    this.y = y1;
    this.dx = dx1;
    this.dy = dy1;
    this.m = m1;
    this.isStatic = y;
    this.isDuplicate = false;}
  Satellite(float x1, float y1, float dx1, float dy1, float m1, boolean y, color c, boolean isD) {
    this.c1 = c;
    this.x = x1;
    this.y = y1;
    this.dx = dx1;
    this.dy = dy1;
    this.m = m1;
    this.isStatic = y;
    this.isDuplicate = isD;}
  void iterate(Satellite body, float iterator) {
    this.setDX(this.getDX() + this.calcGravX(body));
    this.setDY(this.getDY() + this.calcGravY(body));
    this.x += iterator*this.dx;
    this.y += iterator*this.dy;}
  void sketch() {
    fill(c1);
    ellipse(x,y,6,6);
    point(x,y);}
  boolean returnStatic() {return this.isStatic;}
  boolean returnDuplicate() {return this.isDuplicate;}
  float calcGravX(Satellite center) {
    return (center.getX()-this.x)*G*center.getM()/pow(sq(this.x-center.getX())+sq(this.y-center.getY()),1.5);}
  float calcGravY(Satellite center) {
    return (center.getY()-this.y)*G*center.getM()/pow(sq(this.x-center.getX())+sq(this.y-center.getY()),1.5);}
  float getX() {return this.x;}
  float getY() {return this.y;}
  float getM() {return this.m;}
  void setX(float x1) {this.x = x1;}
  void setY(float y1) {this.y = y1;}
  float getDX() {return this.dx;}
  float getDY() {return this.dy;}
  void setDX(float x1) {this.dx = x1;}
  void setDY(float y1) {this.dy = y1;}
}
