package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;

import ui.ScreenMenu;
import ui.TemperatureStatus;

class MachineState extends FlxState {
  static inline var SCREEN_X = 100;
  static inline var SCREEN_Y = 50;
  static inline var SCREEN_WIDTH = 600;
  static inline var SCREEN_HEIGHT = 300;
  static inline var SCREEN_MENU_X = 448;
  static inline var SCREEN_MENU_Y = 2;

  static inline var SCREEN_TEMP_STATUS_X = 280;
  static inline var SCREEN_TEMP_STATUS_Y = 50;

  static inline var CURSOR_RADIUS = 5;

  static inline var CURSOR_MOVE_LEFT = 0;
  static inline var CURSOR_MOVE_RIGHT = 1;
  static inline var CURSOR_MOVE_UP = 2;
  static inline var CURSOR_MOVE_DOWN = 3;
  static inline var CURSOR_MOVE_SPEED = 100;

  private var cursor:FlxSprite;
  private var screen:FlxSpriteGroup;
  private var screenMenu:ScreenMenu;
  private var temperatureStatus:TemperatureStatus;

  override public function create():Void {
    super.create();
    bgColor = FlxColor.WHITE;
    setupScreen();
  }

  override public function update(elapsed:Float):Void {
    if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.W) {
      moveCursor(CURSOR_MOVE_LEFT, elapsed);
    }
    if (FlxG.keys.pressed.RIGHT || FlxG.keys.pressed.D) {
      moveCursor(CURSOR_MOVE_RIGHT, elapsed);
    }
    if (FlxG.keys.pressed.UP || FlxG.keys.pressed.W) {
      moveCursor(CURSOR_MOVE_UP, elapsed);
    }
    if (FlxG.keys.pressed.DOWN || FlxG.keys.pressed.S) {
      moveCursor(CURSOR_MOVE_DOWN, elapsed);
    }
    super.update(elapsed);
  }

  private function setupScreen():Void {
    screen = new FlxSpriteGroup(SCREEN_X, SCREEN_Y);
    add(screen);
    var screenBg = new FlxSprite(0, 0);
    screenBg.makeGraphic(SCREEN_WIDTH, SCREEN_HEIGHT, FlxColor.BLACK, true);
    screen.add(screenBg);
    createCursor();
    createScreenMenu();
    createTemperatureStatus();
  }

  private function createTemperatureStatus():Void {
    temperatureStatus = new TemperatureStatus(SCREEN_TEMP_STATUS_X, SCREEN_TEMP_STATUS_Y);
    screen.add(temperatureStatus);
  }

  private function createScreenMenu():Void {
    screenMenu = new ScreenMenu();
    screenMenu.x = SCREEN_MENU_X;
    screenMenu.y = SCREEN_MENU_Y;
    screen.add(screenMenu);
  }

  private function createCursor():Void {
    cursor = new FlxSprite();
    cursor.makeGraphic(2 * CURSOR_RADIUS, 2 * CURSOR_RADIUS, FlxColor.WHITE);
    screen.add(cursor);
  }

  private function moveCursor(action:Int, elapsed:Float) {
    var movement = elapsed * CURSOR_MOVE_SPEED;
    switch(action) {
      case CURSOR_MOVE_UP:
        cursor.y -= movement;
      case CURSOR_MOVE_DOWN:
        cursor.y += movement;
      case CURSOR_MOVE_LEFT:
        cursor.x -= movement;
      case CURSOR_MOVE_RIGHT:
        cursor.x += movement;
    }

    if (cursor.x < SCREEN_X) {
      cursor.x = SCREEN_X;
    } else if (cursor.x > SCREEN_X + SCREEN_WIDTH) {
      cursor.x = SCREEN_X + SCREEN_WIDTH;
    }

    if (cursor.y < SCREEN_Y) {
      cursor.y = SCREEN_Y;
    } else if (cursor.y > SCREEN_Y + SCREEN_HEIGHT) {
      cursor.y = SCREEN_Y + SCREEN_HEIGHT;
    }
  }

}
