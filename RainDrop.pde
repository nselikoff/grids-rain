class RainDrop {
  boolean reflect;
  float offsetX;
  float offsetY;
  float offsetZ;
  int speed;
  float speedFloat;
  float weight;
  float a, b;
  float alpha;
  int type;
  float spawnY;
  
  RainDrop() {
    a = 3.0;
    b = 4.0;
    type = 0;
    reflect = false;
    offsetX = offsetY = offsetZ = 0;
    speed = 1;
    speedFloat = 10.0;
    weight = 1.0;
    alpha = 255;
    spawnY = 250;
    respawn();
  }
  
  void respawn() {
    switch(type) {
      case 3: // geometric
        spawnY = 250;
        reflect = false;
        offsetX = int(random(-142, 144)) * 7;
        offsetY = spawnY + int(random(0, 25)) * b;
        //offsetZ = random(-400, 0);
        offsetZ = 0;
        speed = int(random(1, 5));
        // speed = 1;
        weight = random(0.5, 1.5);
        // weight = 2.0;
        alpha = random(32, 255);
      break;

      case 2: // driving
        spawnY = 250;
        offsetX = random(-960, 960);
        offsetY = spawnY + int(random(0, 100));
        offsetZ = 0;
        speedFloat = random(2, 20);
        weight = speedFloat * 0.25;
        alpha = speedFloat * 12.75;
      break;

      case 1: // straight
        spawnY = 2500;
        offsetX = random(-960, 960);
        offsetY = spawnY + int(random(0, 100));
        offsetZ = 0;
        speedFloat = random(50, 200);
        weight = 1.0;
        alpha = 128;
      break;

      case 0: // noise
        spawnY = 2500;
        offsetX = noise(frameCount * 0.03) * 1920 - 960;
        offsetY = spawnY + int(random(0, 100));
        offsetZ = 0;
        speedFloat = random(50, 200);
        weight = 1.0;
        alpha = 128;
      break;
    }
  }    
  
  void update(float extraOffset) {
    switch(type) {
      case 3:
        //offsetZ += 10;
        if (frameCount % speed == 0) {
          reflect = !reflect;
          offsetY -= b;
        }
      break;

      case 2:
        offsetY -= speedFloat;
        offsetZ += speedFloat * 0.5;
      break;

      case 1:
        offsetY -= speedFloat;
      break;

      case 0:
        offsetY -= speedFloat;
      break;
    }

    // offsetZ += extraOffset;

    if (offsetY < -spawnY) {
      respawn();
    }
  }
  
  void draw() {
    pushMatrix();
      stroke(255, alpha);
      strokeWeight(weight);
      noFill();
      translate(offsetX, offsetY, offsetZ);
      switch(type) {
        case 3:
          //rotateX(-PI/12);
          if (reflect) {
            translate(-a, 0);
            scale(-1, 1);
          }
          beginShape();
            vertex(0, 0);
            vertex(-a, -b);
            vertex(0, -b * 2);
            vertex(-a, -b * 3);
            vertex(0, -b * 4);
            vertex(-a, -b * 5);
          endShape();
        break;

        case 2:
          // rect(0, 0, 10, 10);
          line(0, 0, 0, 10);
        break;

        case 1:
          line(0, 0, 0, speedFloat);
        break;

        case 0:
          line(0, 0, 0, speedFloat);
        break;
      }
    popMatrix();
  }
};