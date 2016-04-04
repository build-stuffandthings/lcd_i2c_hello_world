#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <Wire.h> 
#include <LiquidCrystal_I2C.h>

// Set the LCD address to 0x27 for a 16 chars and 2 line display
LiquidCrystal_I2C lcd(0x27, 20, 4);

const char* ssid = "";
const char* password = "";
const char* mqtt_server = "";

WiFiClient espClient;
PubSubClient client(espClient);
long lastMsg = 0;
char msg[50];
int value = 0;
int ledPin = 2;
String strPayload;
String strTopic;
String backgarden;
String livingroom;
String spareroom;
String dexterroom;
String power;
String heating;
int page = 0;

const int changemenubuttonPin = 4;     // the number of the pushbutton pin
const int changemenuoptionPin = 13;
const int selectmenuoptionPin = 12;

int menubuttonState = 0;         // variable for reading the pushbutton status
int lastmenuButtonState = 0;

int optionbuttonState = 0;         // variable for reading the pushbutton status
int lastoptionButtonState = 0;

int selectbuttonState = 0;         // variable for reading the pushbutton status
int lastselectButtonState = 0;

int menu = 0;
int lastmenu = 0;
int option = 0;
int lastoption = 0;
int State = 0;

int showoption = 0;

long debounceDelay = 50;    // the debounce time; increase if the output flickers
long lastmenuDebounceTime = 0;  // the last time the output pin was toggled
long lastoptionDebounceTime = 0;  // the last time the output pin was toggled
long lastselectDebounceTime = 0;  // the last time the output pin was toggled

int menuOptions[] = {3, 2, 4};

void callback(char* topic, byte* payload, unsigned int length) {
  payload[length] = '\0';
  strTopic = String((char*)topic);
  if(strTopic == "ha/backgarden_temperature")
    {
      backgarden = String((char*)payload);
    }
  if(strTopic == "ha/_temperature1")
      {
      livingroom = String((char*)payload);
    }
  if(strTopic == "ha/spareroom_temperature")
      {
      spareroom = String((char*)payload);
    }    
  if(strTopic == "ha/dexterroom_temperature")
      {
      dexterroom = String((char*)payload);
    }
  if(strTopic == "ha/power")
    {
      power = String((char*)payload);
    }
  if(strTopic == "ha/heating")
    {
    heating = String((char*)payload);
    }
}


void setup_wifi() {
  delay(10);
  // We start by connecting to a WiFi network
  lcd.clear();
  lcd.home();
  lcd.print("Connecting to :");
  lcd.setCursor(0,1);
  lcd.print(ssid);

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
    lcd.print(".");
  }

  lcd.clear();
  lcd.home();
  lcd.print("WiFi connected");
  lcd.setCursor(0,1);
  lcd.print("IP address : ");
  lcd.setCursor(0,2);
  lcd.print(WiFi.localIP());
  delay(2000);
}

void displayMenu(int menu, int show)
{
if(menu == lastmenu && show == 0)
  {
    return;
  }
  lastmenu = menu;
  switch(menu){
    case 0:
      lcd.home();
      lcd.print("1/1 - Utilities");
      lcd.setCursor(0,1);
      lcd.print("1/2 - Temperatures");
      lcd.setCursor(0,2);
      lcd.print("1/3 - Switches");
      break;
    case 1:
      lcd.home();
      lcd.print("2/1 - Test 1");
      lcd.setCursor(0,1);
      lcd.print("2/2 - Test 2");
      break;
    case 2:
      lcd.home();
      lcd.print("3/1 - Nothing");
      lcd.setCursor(0,1);
      lcd.print("3/2 - Nothing");
      lcd.setCursor(0,2);
      lcd.print("3/3 - Nothing");
      lcd.setCursor(0,3);
      lcd.print("3/4 - Nothing");
      break;
  }                    
}

void highlightMenuOption(int option)
{
  lcd.setCursor(19, 0);
  lcd.print(" ");
  lcd.setCursor(19, 1);
  lcd.print(" ");
  lcd.setCursor(19, 2);
  lcd.print(" ");
  lcd.setCursor(19, 3);
  lcd.print(" ");
  lcd.setCursor(19 , option);
  lcd.print("<");
}


void setup()
{
  Serial.begin(115200);
  Wire.begin(2, 0);
        // initialize the LCD
        lcd.begin();
  setup_wifi();
  client.setServer(mqtt_server, 1883);
  client.setCallback(callback);
  pinMode(changemenubuttonPin, INPUT);
  digitalWrite(changemenubuttonPin, HIGH);
  pinMode(changemenuoptionPin, INPUT);
  digitalWrite(changemenuoptionPin, LOW);
  pinMode(selectmenuoptionPin, INPUT);
  digitalWrite(changemenuoptionPin, HIGH);
  highlightMenuOption(option);
  displayMenu(menu, 1);
}

void reconnect() {
  // Loop until we're reconnected
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    // Attempt to connect
    if (client.connect("ESP8266Client")) {
      Serial.println("connected");
      // Once connected, publish an announcement...
//      client.publish("outTopic", "hello world");
      // ... and resubscribe
      client.subscribe("ha/#");
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      // Wait 5 seconds before retrying
      delay(1000);
    }
  }
}



void showscreen(int menu, int option)
{
  switch (menu){
    case 0:
      switch(option){
        case 0:
          lcd.clear();  
          lcd.setCursor(0, 0);
          lcd.print("Heating : ");
          lcd.print(heating);
          lcd.setCursor(0, 1);
          lcd.print("Power : ");
          lcd.print(power);
          lcd.print("watts");
          break;
        case 1:
          lcd.clear();
          lcd.setCursor(0, 0);
          lcd.print("Outside : ");
          lcd.print(backgarden);
          lcd.print((char)223);
          lcd.print("C");      
          lcd.setCursor(0, 1);
          lcd.print("Livingroom : ");
          lcd.print(livingroom);
          lcd.print((char)223);
          lcd.print("C");
          lcd.setCursor(0, 2);
          lcd.print("Spareroom : ");
          lcd.print(spareroom);
          lcd.print((char)223);
          lcd.print("C");
          lcd.setCursor(0, 3);
          lcd.print("Dexterroom : ");
          lcd.print(dexterroom);
          lcd.print((char)223);
          lcd.print("C");
          break;
        case 2:
          lcd.clear();
          lcd.print("switches");
          break;
      }
      break;
    case 1:
      switch(option){
        case 0:
          lcd.clear();
          lcd.print("testing 1");
          break;
        case 1:
          lcd.clear();
          lcd.print("testing 2");
          break;
      }
      break;
    default:
      lcd.clear();
      lcd.print("Nothing to show yet!");
      break;
  }
}

void loop()
{
  if (!client.connected()) {
    reconnect();
  }
  client.loop();
    
  int menureading = digitalRead(changemenubuttonPin);
  if (menureading != lastmenuButtonState) {
    lastmenuDebounceTime = millis();
  }

  if ((millis() - lastmenuDebounceTime) > debounceDelay) {
    if (menureading != menubuttonState) {
      menubuttonState = menureading;
      if (menubuttonState == LOW && showoption == 0) {
          lcd.clear();
          menu ++;
          option = 0;
          if(menu == 3)
            {
               menu = 0;
            }
          highlightMenuOption(option);
          displayMenu(menu, 1);
          }
        }
      }
  lastmenuButtonState = menureading;

  int optionreading = digitalRead(changemenuoptionPin);
  if (optionreading != lastoptionButtonState) {
    lastoptionDebounceTime = millis();
  }

  if ((millis() - lastoptionDebounceTime) > debounceDelay) {
    if (optionreading != optionbuttonState) {
      optionbuttonState = optionreading;
      if (optionbuttonState == HIGH && showoption == 0) {
          //lcd.clear();
          option ++;
          if(option == menuOptions[menu])
            {
               option = 0;
            }
          highlightMenuOption(option);
          displayMenu(menu, 1);
      }
    }
  }
  lastoptionButtonState = optionreading;


  int selectreading = digitalRead(selectmenuoptionPin);
  if (selectreading != lastselectButtonState) {
    lastselectDebounceTime = millis();
  }

  if ((millis() - lastselectDebounceTime) > debounceDelay) {
    if (selectreading != selectbuttonState) {
      selectbuttonState = selectreading;
      if (selectbuttonState == LOW) {
          lcd.clear();
          if(showoption == 0)
            {
              showoption = 1;
              showscreen(menu, option);
            }
          else
            {
              showoption = 0;
              highlightMenuOption(option);
              displayMenu(menu, 1);
            }
      }
    }
  }
  lastselectButtonState = selectreading;

  long now = millis();
  if (now - lastMsg > 5000) {
    lastMsg = now;
    if(showoption == 1)
      {
        showscreen(menu, option);
      }
  }
}
