import codeanticode.syphon.*;

SyphonServer server;

RainDrop[] rainDrops;
int numRainDrops = 10000;
int numActiveRainDrops = 1000;

int screenWidth = 1280, screenHeight = 289;
//int screenWidth = 1920, screenHeight = 434;

void settings() {
  size(screenWidth, screenHeight, P3D);
  PJOGL.profile=1; // OpenGL 1.2 / 2.x context, for Syphon compatibility
}

void setup() {

  // Create syhpon server to send frames out.
  server = new SyphonServer(this, "sketch_thread_lattice");

  //size(1280, 289, P3D);
  frameRate(60);
  smooth(8);
  
  rainDrops = new RainDrop[numRainDrops];
  
  for (int i = 0; i < numRainDrops; i++) {
    rainDrops[i] = new RainDrop();
  }
}

void draw() {
  background(0);
  
  //numActiveRainDrops = int(map(sin(frameCount * 0.01) * 0.5 + 0.5, 0, 1, 100, 10000));

  for (int i = 0; i < numActiveRainDrops; i++) {
    rainDrops[i].update();
  }
  
  translate(width/2, height/2);
  scale(1, -1, 1);

  for (int i = 0; i < numActiveRainDrops; i++) {
    rainDrops[i].draw();
  }
  
  server.sendScreen();
}