import processing.serial.*;

Serial port;

void FindComp() {
  frameRate(100);
Match:
  for (int i = 0; i < Serial.list().length; i++) {
    try {
      println(i, Serial.list()[i]);
      port = new Serial(this, Serial.list()[i], 9600);
      port.bufferUntil('\n');
      port.buffer(5);
    }
    catch(Exception e) {
      continue Match;
    }
    if (port.readString() == "Hello") {
      println("MATCH");
      break;
    }
  }
}
String[] strings, JS, IMUg, IMUa;
void Split() {
    try {
      JS = split(strings[0], ",");
      IMUg = split(strings[1], ",");
      IMUa = split(strings[2], ",");
    }
    catch(Exception e) {
    }
  
}

boolean Hello;
void serialEvent(Serial port) {
  String myString = port.readStringUntil('\n');
  if ( myString  != null ) {
    strings = split(myString, ";");
    //println(myString);
    if (!Hello) {
      println("loading");
      strings = split(myString, ";");
      delay(10000);
      Hello = true;
    }
  }
}
