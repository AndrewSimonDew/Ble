#include <SoftwareSerial.h>
SoftwareSerial HM10(2, 3);
int data;
#define red 13
#define yellow 12
#define green 11
#define blue 10
void setup() {
  Serial.begin(9600);
  HM10.begin(9600);
  pinMode(red, OUTPUT);
  pinMode(yellow, OUTPUT);
  pinMode(green, OUTPUT);
  pinMode(blue, OUTPUT);
}

void loop() {
  HM10.listen();
  while (HM10.available() > 0) {
    Serial.println(HM10.read());
    data = HM10.read();
    if (data == 1) {
      Serial.println("1!!!!");
      digitalWrite(red, HIGH);
      digitalWrite(red, LOW);
      digitalWrite(red, LOW);
      digitalWrite(red, LOW);
    } else if (data == 2) {
      digitalWrite(red, LOW);
      digitalWrite(red, HIGH);
      digitalWrite(red, LOW);
      digitalWrite(red, LOW);
    } else if (data == 3) {
      digitalWrite(red, LOW);
      digitalWrite(red, LOW);
      digitalWrite(red, HIGH);
      digitalWrite(red, LOW);
    } else if (data == 4) {
      digitalWrite(red, LOW);
      digitalWrite(red, LOW);
      digitalWrite(red, LOW);
      digitalWrite(red, HIGH);
    } else if (data == 5) {
      digitalWrite(red, LOW);
      digitalWrite(red, LOW);
      digitalWrite(red, LOW);
      digitalWrite(red, LOW);
    } else if (data == 6) {
      digitalWrite(red, HIGH);
      digitalWrite(red, LOW);
      digitalWrite(red, LOW);
      digitalWrite(red, LOW);
    }
  }
}
