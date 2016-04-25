#include <LBT.h>
#include <LBTServer.h>
#define SPP_SVR "1110101110" // it is the server's visible name, customize it yourself.
#define ard_log Serial.printf

// constants won't change. Used here to set a pin number :
const int ledPin =  13;      // the number of the LED pin
const int LiFiPin =  14;      // the number of the LED pin
const int LiFiInputPin =  4;      // the number of the Photodiode pin
const int buttonPin = 2;     // the number of the pushbutton pin
const char ID = 0xD7;
// Variables will change :
int ledState = LOW;             // ledState used to set the LED
int LiFiState = LOW;             // ledState used to set the LED
int buttonState = 0;         // variable for reading the pushbutton status
bool success = 0;   //BLT 連線狀態
bool BLT_state = 0;
char LiFiBit,LiFiByte, offset, rID;
char smLiFi = 0;
// Generally, you should use "unsigned long" for variables that hold time
// The value will quickly become too large for an int to store
unsigned long previousMillis = 0;        // will store last time LED was updated
unsigned long LiFipreviousMillis = 0;        // will store last time LED was updated
unsigned long LBTstartTime = 0;
// constants won't change :
long interval = 250;           // interval at which to blink (milliseconds)
const long LiFi_interval = 500;           // interval at which to blink (milliseconds)
const long LBTtime = 180000 ; // 180 seconds
int read_size = 0;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);
  
  pinMode(LiFiPin, OUTPUT);
  pinMode(LiFiInputPin, INPUT);
 
  pinMode(buttonPin, INPUT);
  success = LBTServer.begin((uint8_t*)SPP_SVR);
  if ( !success )
  {
    ard_log("Cannot begin Bluetooth Server successfully\n");
    // don't do anything else
    delay(0xffffffff);
  }
  else
  {
    LBTDeviceInfo info;
    if (LBTServer.getHostDeviceInfo(&info))
    {
      ard_log("LBTServer.getHostDeviceInfo [%02x:%02x:%02x:%02x:%02x:%02x]",
              info.address.nap[1], info.address.nap[0], info.address.uap, info.address.lap[2], info.address.lap[1], info.address.lap[0]);
      LBTstartTime = millis();
      BLT_state = 1;
    }
    else
    {
      ard_log("LBTServer.getHostDeviceInfo failed\n");
    }
    ard_log("Bluetooth Server begin successfully\n");
  }
  //
  //  // waiting for Spp Client to connect
  //  bool connected = LBTServer.accept(1800);
  //
  //  if( !connected )
  //  {
  //      ard_log("No connection request yet\n");
  //      // don't do anything else
  //      delay(0xffffffff);
  //  }
  //  else
  //  {
  //      ard_log("Connected\n");
  //  }
}

int sent = 0;
void loop() {
  // put your main code here, to run repeatedly:
  unsigned long currentMillis = millis();
//  if (currentMillis - previousMillis >= 1500) {
//    previousMillis = currentMillis;
//    LiFiWrite(ID);
//  }


  
  if (currentMillis - previousMillis >= interval) {
    // save the last time you blinked the LED
    previousMillis = currentMillis;

    // if the LED is off turn it on and vice-versa:
    if (ledState == LOW) {
      ledState = HIGH;
    } else {
      ledState = LOW;
    }

    // set the LED with the ledState of the variable:
    digitalWrite(ledPin, ledState);
    Serial.print("time: ");
    Serial.println(currentMillis);

  }

  // ===============================================================
  if (currentMillis - LiFipreviousMillis >= LiFi_interval) {
    // save the last time you blinked the LED
    LiFipreviousMillis = currentMillis;

    // if the LED is off turn it on and vice-versa:
    LiFiBit = digitalRead(LiFiInputPin);
    switch(smLiFi){
      case 0:
        if( LiFiBit ==1)
          smLiFi = 1;
          offset = 0;
      break;
      case 1:
         LiFiByte |=  LiFiBit << offset;
         offset++;
         if(offset>7)
           smLiFi = 2;
      break;
      case 2:
        if( LiFiBit == 0)
        {
         rID = LiFiByte;
         if(rID == ID)
            LiFiWrite(ID);
        }
           smLiFi = 0;
      break;
    }
  }
  //===================================================================
  if ( currentMillis - LBTstartTime >= LBTtime) {
    LBTServer.end();
    interval = 1000;
    BLT_state = 0;
  }
  //===================================================================
  buttonState = digitalRead(buttonPin);
  // check if the pushbutton is pressed.
  // if it is, the buttonState is HIGH:
  if (buttonState == HIGH) {
    interval = 250;
    if (!BLT_state) {
      success = LBTServer.begin((uint8_t*)SPP_SVR);
      if ( !success )
      {
        ard_log("Cannot begin Bluetooth Server successfully\n");
        // don't do anything else
        delay(0xffffffff);
      }
      else
      {
        LBTDeviceInfo info;
        if (LBTServer.getHostDeviceInfo(&info))
        {
          ard_log("LBTServer.getHostDeviceInfo [%02x:%02x:%02x:%02x:%02x:%02x]",
                  info.address.nap[1], info.address.nap[0], info.address.uap, info.address.lap[2], info.address.lap[1], info.address.lap[0]);
          LBTstartTime = millis();
          BLT_state = 1;
        }
        else
        {
          ard_log("LBTServer.getHostDeviceInfo failed\n");
        }
        ard_log("Bluetooth Server begin successfully\n");
      }
    }// end if BLT_state
  } // end if buttonState

}

//===================================================================
void LiFiWrite(byte data)
{
  byte mask;
  //startbit
  digitalWrite(LiFiPin,HIGH);
  delay(LiFi_interval);
  for (mask = 0x01; mask>0; mask <<= 1) {
    if (data & mask){ // choose bit
     digitalWrite(LiFiPin,HIGH); // send 1
    }
    else{
     digitalWrite(LiFiPin,LOW); // send 0
    }
    delay(LiFi_interval);
  }
  //stop bit
  digitalWrite(LiFiPin, LOW);
  Serial.println("LiFiWrite");
}
