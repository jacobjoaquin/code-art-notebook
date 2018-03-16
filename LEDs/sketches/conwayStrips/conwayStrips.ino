#include <FastLED.h>

#define LED_PIN_0    2
#define LED_PIN_1    7
#define LED_PIN_2    14
#define COLOR_ORDER  GRB
#define CHIPSET      WS2811
#define BRIGHTNESS   255

const uint8_t kMatrixWidth = 60;
const uint8_t kMatrixHeight = 8;
const bool  kMatrixSerpentineLayout = true;
const int nPixels = kMatrixWidth * kMatrixHeight;
const uint16_t nLEDs = kMatrixWidth * kMatrixHeight;

boolean grid[kMatrixHeight][kMatrixWidth];
boolean temp[kMatrixHeight][kMatrixWidth];

uint32_t frameDelay = 0;
uint32_t interpFrames = 8;
uint32_t interpCounter = interpFrames;
uint32_t nFrames = 120;
uint32_t frameCounter = nFrames;

CRGB cBlack = CRGB(0, 0, 0);
CRGB c0 = CRGB(255, 0, 32);
CRGB c1 = CRGB(128, 32, 0);
CRGB c2 = CRGB(255, 32, 128);

//CRGB leds_plus_safety_pixel[nLEDs + 1];
//CRGB* const leds(leds_plus_safety_pixel + 1);
CRGB leds[nLEDs * 3 + 1];

int16_t XY(uint8_t x, uint8_t y) {
  int i = x % 2;
  return (x + i) * kMatrixHeight - i + (i ? -y : y);
}

void initGrid() {
  uint32_t odds = random(10, 60);
  for (long y = 0; y < kMatrixHeight; y++) {
    for (long x = 0; x < kMatrixWidth; x++) {
      grid[y][x] = random(100) < odds;
    }
  }
}

void initGlider() {
  grid[0][1] = true;
  grid[1][2] = true;
  grid[2][0] = true;
  grid[2][1] = true;
  grid[2][2] = true;
}

boolean isAlive(long x, long y) {
  return grid[y][x];
}

int countAdjacent(int x, int y) {
  int count = 0;
  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      if (!(i == 0 && j == 0)) {
        int xOffset = x + j;
        int yOffset = y + i;
        if (xOffset < 0) {
          xOffset += kMatrixWidth;
        } else if (xOffset >= kMatrixWidth) {
          xOffset -= kMatrixWidth;
        }
        if (yOffset < 0) {
          yOffset += kMatrixHeight;
        } else if (yOffset >= kMatrixHeight) {
          yOffset -= kMatrixHeight;
        }

        if (isAlive(xOffset, yOffset)) {
          count++;
        }
      }
    }
  }
  return count;
}

void tempToGrid() {
  for (int y = 0; y < kMatrixHeight; y++) {
    for (int x = 0; x < kMatrixWidth; x++) {
      grid[y][x] = temp[y][x];
    }
  }
}

void setup() {
  FastLED.addLeds<CHIPSET, LED_PIN_0, COLOR_ORDER>(leds, 0, nLEDs).setCorrection(TypicalSMD5050);
  FastLED.addLeds<CHIPSET, LED_PIN_1, COLOR_ORDER>(leds, nLEDs, nLEDs).setCorrection(TypicalSMD5050);
  FastLED.addLeds<CHIPSET, LED_PIN_2, COLOR_ORDER>(leds, nLEDs * 2, nLEDs).setCorrection(TypicalSMD5050);
  FastLED.setBrightness(BRIGHTNESS);
  randomSeed(analogRead(0));
  initGrid();
  //  initGlider();
}

void loop() {
  FastLED.clear();

  for (int y = 0; y < kMatrixHeight; y++) {
    for (int x = 0; x < kMatrixWidth; x++) {
      boolean isAlive = grid[y][x];

      int liveCells = countAdjacent(x, y);
      if (isAlive) {
        temp[y][x] = liveCells == 2 || liveCells == 3;
      } else {
        temp[y][x] = liveCells == 3;
      }
    }
  }


  for (uint32_t i = 0; i < interpFrames; i++) {
    FastLED.clear();

    for (long y = 0; y < kMatrixHeight; y++) {
      for (long x = 0; x < kMatrixWidth; x++) {
        int nAdjacent = countAdjacent(x, y);
        CRGB c;

        if (nAdjacent == 8) {
          c = c2;
        } else {
          c = c0.lerp8(c1, nAdjacent * 32);
        }

        float n = (float) i / interpFrames;
        float g0 = grid[y][x];
        float g1 = temp[y][x];

        float amt = (1 - n) * g0 + n * g1;
        CRGB temp = cBlack.lerp8(c, amt * 255);
        uint16_t index = XY(x, y);
        leds[index] = temp;
        leds[index + nLEDs] = temp;
        leds[index + nLEDs * 2] = temp;
      }

    }
    FastLED.show();
    delay(frameDelay);
  }

  tempToGrid();

  frameCounter--;
  if (frameCounter == 0) {
    initGrid();
    frameCounter = nFrames;
  }
}

