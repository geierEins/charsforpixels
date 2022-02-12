import processing.video.*;

Capture video;
String density = "Ñ@#W$9876543210?!abc;:+=-,._";

void setup() {
  size(640, 480);
  printArray(Capture.list());
  println("---");
  // need this camera name to make it work
  video = new Capture(this, "pipeline:autovideosrc");
  video.start();
  println("video.width: " + video.width + ", video.height: " + video.height);
}

void draw() {
  background(150);
  
  int pixelsize = 5;

  for (int x = 0; x < video.width; x+=pixelsize) {
    for (int y = 0; y < video.height; y+=pixelsize) {
      // Calculate the 1D location from a 2D grid
      int loc = x + y * video.width;

      // Get the red, green, blue values from a pixel
      float r = red  (video.pixels[loc]);
      float g = green(video.pixels[loc]);
      float b = blue (video.pixels[loc]);
      
      float avgBrightness = (r+g+b)/3;
      noStroke();
      fill(r, g, b);
      //square(x, y, pixelsize);
      int indexOfChar = floor(map(avgBrightness, 0, 255, density.length()-1, 0));
      textSize(pixelsize+3);
      text(density.charAt(indexOfChar), x, y);
      
    }
  }
  
}

void captureEvent(Capture video) {
  video.read();
}
