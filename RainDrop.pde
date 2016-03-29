class RainDrop {
  boolean reflect;
  float offsetX;
  float offsetY;
  float offsetZ;
  int speed;
  float weight;
  
  RainDrop() {
    respawn();
  }
  
  void respawn() {
    reflect = false;
    offsetX = int(random(-71, 72)) * 9;
    offsetY = 200 + int(random(0, 25)) * 12;
    //offsetZ = random(-400, 0);
    offsetZ = 0;
    speed = int(random(1, 5));
    weight = random(0.25, 8);
  }    
  
  void update() {
    //offsetZ += 10;
    if (frameCount % speed == 0) {
      reflect = !reflect;
      offsetY -= 12;
    }
    if (offsetY < -200) {
      respawn();
    }
  }
  
  void draw() {
    pushMatrix();
    stroke(255);
    strokeWeight(weight);
    noFill();
    translate(offsetX, offsetY, offsetZ);
    //rotateX(-PI/12);
    if (reflect) {
      translate(-9, 0);
      scale(-1, 1);
    }
    beginShape();
    vertex(0, 0);
    vertex(-9, -12);
    vertex(0, -24);
    vertex(-9, -36);
    vertex(0, -48);
    vertex(-9, -60);
    endShape();
    //line(0, 0, -9, -12);
    //translate(-9, -12);
    //line(0, 0, 9, -12);
    //translate(9, -12);
    //line(0, 0, -9, -12);
    //translate(-9, -12);
    //line(0, 0, 9, -12);
    //translate(9, -12);
    //line(0, 0, -9, -12);
    popMatrix();
  }
};