#include <SoftwareSerial.h>
SoftwareSerial HM10(2, 3);
int data;
int red = 13;
int yellow = 12;
int green = 11;
int blue = 10;
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
    data = HM10.read();
    if (data == 1) {
      Serial.println("red");
      digitalWrite(red, HIGH);
      digitalWrite(yellow, LOW);
      digitalWrite(green, LOW);
      digitalWrite(blue, LOW);
    } else if (data == 2) {
      Serial.println("yellow");
      digitalWrite(red, LOW);
      digitalWrite(yellow, HIGH);
      digitalWrite(green, LOW);
      digitalWrite(blue, LOW);
    } else if (data == 3) {
      Serial.println("greem");
      digitalWrite(red, LOW);
      digitalWrite(yellow, LOW);
      digitalWrite(green, HIGH);
      digitalWrite(blue, LOW);
    } else if (data == 4) {
      Serial.println("blue");
      digitalWrite(red, LOW);
      digitalWrite(yellow, LOW);
      digitalWrite(green, LOW);
      digitalWrite(blue, HIGH);
    } else if (data == 5) {
      Serial.println("none");
      digitalWrite(red, LOW);
      digitalWrite(yellow, LOW);
      digitalWrite(green, LOW);
      digitalWrite(blue, LOW);
    } else if (data == 6) {
      Serial.println("all");
      digitalWrite(red, HIGH);
      digitalWrite(yellow, HIGH);
      digitalWrite(green, HIGH);
      digitalWrite(blue, HIGH);
    }
  }
}
