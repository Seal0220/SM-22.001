import processing.serial.*;

Serial port;

void setup() {
  frameRate(150);
  //Match:
  //  for (int i = 0; i < Serial.list().length; i++) {
  //    try {
  //      println(i, Serial.list()[i]);
  //      port = new Serial(this, Serial.list()[i], 9600);
  //      port.bufferUntil('\n');
  //      port.buffer(5);
  //    }
  //    catch(Exception e) {
  //      continue Match;
  //    }
  //    if (port.readString() == "Hello") {
  //      println("MATCH");
  //      break;
  //    }
  //  }

  port = new Serial(this, Serial.list()[2], 9600);
  port.bufferUntil('\n');
  port.buffer(5);

  //if (port.readString() == null) {
  //    println("NO MATCH");
  //    noLoop();
  //  }
}
String[] strings, JS, IMUg, IMUa;
void draw() {
  //String[] A = split(all[0], ",");
  //String[] B = split(all[1], ",");
  //String[] C = split(all[1], ",");

  //println(A);
}

void serialEvent(Serial port) {
  port.bufferUntil('\n');
  
  strings = split(port.readString(), ";");
  JS = split(strings[0], ",");
  IMUg = split(strings[1], ",");
  IMUa = split(strings[1], ",");
  println(JS);
}
