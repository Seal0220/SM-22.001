#include <basicMPU6050.h>

#define JSX_Pin A0
#define JSY_Pin A1
#define JSC_Pin 2
#define SCL_Pin A5
#define SDA_Pin A4

int JSX, JSY, JSC;
int JSX_Offset = 0, JSY_Offset = 0;

basicMPU6050<> imu;

void setup() {
  Serial.begin(9600);
  Serial.println("Hello");

  imu.setup();
  imu.setBias();

  pinMode(JSX_Pin, INPUT);
  pinMode(JSY_Pin, INPUT);
  pinMode(JSC_Pin, INPUT_PULLUP);
  pinMode(SCL_Pin, INPUT);
  pinMode(SDA_Pin, INPUT);

  JSX_Offset = analogRead(JSX_Pin);
  JSY_Offset = analogRead(JSY_Pin);
}

void JoyStick() {
  JSX = analogRead(JSX_Pin);
  JSY = analogRead(JSY_Pin);
  JSC = digitalRead(JSC_Pin);
  JSX = (JSX - JSX_Offset);
  JSY = (JSY - JSY_Offset);

  Serial.print(JSX);
  Serial.print(",");
  Serial.print(JSY);
  Serial.print(",");
  Serial.print(JSC);
  Serial.print(";");
}

void IMU() {
  imu.updateBias();
  // Gyro
  Serial.print(imu.ax());
  Serial.print(",");
  Serial.print(imu.ay());
  Serial.print(",");
  Serial.print(imu.az());
  Serial.print(";");

  // Accel
  Serial.print(imu.gx());
  Serial.print(",");
  Serial.print(imu.gy());
  Serial.print(",");
  Serial.print(imu.gz());
  Serial.print(";");
}

void loop() {
  JoyStick();
  IMU();

  Serial.println();
  delay(100);
}