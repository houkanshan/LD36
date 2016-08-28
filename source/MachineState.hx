package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

class MachineState extends FlxState {
  static inline var SCREEN_WIDTH = 600;
  static inline var SCREEN_HEIGHT = 400;
  static inline var CURSOR_RADIUS = 5;

  static inline var CURSOR_MOVE_LEFT = 0;
  static inline var CURSOR_MOVE_RIGHT = 1;
  static inline var CURSOR_MOVE_UP = 2;
  static inline var CURSOR_MOVE_DOWN = 3;
  static inline var CURSOR_MOVE_SPEED = 100;

  private var cursor:FlxSprite;

  override public function create():Void {
    super.create();
    createCursor();
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

  private function createCursor():Void {
    cursor = new FlxSprite();
    cursor.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);
    add(cursor);
    cursor.drawCircle(CURSOR_RADIUS, CURSOR_RADIUS, CURSOR_RADIUS, FlxColor.WHITE);
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

    if (cursor.x < 0) {
      cursor.x = 0;
    } else if (cursor.x > SCREEN_WIDTH) {
      cursor.x = SCREEN_WIDTH;
    }

    if (cursor.y < 0) {
      cursor.y = 0;
    } else if (cursor.y > SCREEN_HEIGHT) {
      cursor.y = SCREEN_HEIGHT;
    }
  }

}
