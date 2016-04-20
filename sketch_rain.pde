import codeanticode.syphon.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myBroadcastLocation; 

SyphonServer server;

RainDrop[] rainDrops;
int numRainDrops = 10000;
int numActiveRainDrops = 1;
float offsetX = 0;

// int screenWidth = 1280, screenHeight = 289;
int screenWidth = 1920, screenHeight = 434;

void settings() {
  size(screenWidth, screenHeight, P3D);
  PJOGL.profile=1; // OpenGL 1.2 / 2.x context, for Syphon compatibility
}

void setup() {

  // Create syhpon server to send frames out.
  server = new SyphonServer(this, "sketch_rain");

  oscP5 = new OscP5(this,12000);

  frameRate(60);
  // smooth(8);
  
  rainDrops = new RainDrop[numRainDrops];
  
  for (int i = 0; i < numRainDrops; i++) {
    rainDrops[i] = new RainDrop();
  }
}

void draw() {
  background(0);
  
  //numActiveRainDrops = int(map(sin(frameCount * 0.01) * 0.5 + 0.5, 0, 1, 100, 10000));

  for (int i = 0; i < numRainDrops; i++) {
    rainDrops[i].update(offsetX);
  }
  
  translate(width/2, height/2);
  scale(1, -1, 1);

  for (int i = 0; i < numActiveRainDrops; i++) {
    rainDrops[i].draw();
  }

  if (frameCount % 60 == 0) {
    println(frameRate);
  }
  
  server.sendScreen();
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  String addr = theOscMessage.addrPattern();
  String typetag = theOscMessage.typetag();
  float floatVal = 0;
  boolean boolVal = false;
  
  if (typetag.equals("f"))
    floatVal = theOscMessage.get(0).floatValue();
  else if (typetag.equals("b"))
    boolVal = theOscMessage.get(0).booleanValue();
  
  if (addr.equals("/FromVDMX/Slider1")) {
  }
  else if (addr.equals("/FromVDMX/Slider2")) {
  }
  else if (addr.equals("/FromVDMX/Slider3")) {
  }
  else if (addr.equals("/FromVDMX/Slider4")) {
  }
  else if (addr.equals("/FromVDMX/Slider5")) {
    numActiveRainDrops = int(map(floatVal, 0, 1, 1, 10000));
  }
  else if (addr.equals("/FromVDMX/Slider6")) {
    offsetX = map(floatVal, 0, 1, -10, 10);
  }
  else if (addr.equals("/FromVDMX/Slider7")) {
  }
  else if (addr.equals("/FromVDMX/Slider8")) {
  }
  else if (addr.equals("/FromVDMX/S1")) {
  }
  else if (addr.equals("/FromVDMX/M1")) {
  }
  else if (addr.equals("/FromVDMX/R1")) {
  }
  else if (addr.equals("/FromVDMX/track/prev")) {
    int newType = rainDrops[0].type - 1;
    if (newType < 0) { newType = 0; }
    println("prev: set rainDrop type to " + newType);
    for (int i = 0; i < numRainDrops; i++) {
      rainDrops[i].type = newType;
    }
  }
  else if (addr.equals("/FromVDMX/track/next")) {
    int newType = (rainDrops[0].type + 1) % 4;
    println("next: set rainDrop type to " + newType);
    for (int i = 0; i < numRainDrops; i++) {
      rainDrops[i].type = newType;
    }
  }

  // theOscMessage.print();
}
